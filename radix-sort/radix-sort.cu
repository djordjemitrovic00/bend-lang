#include <stdio.h>
#include <cuda_runtime.h>

__global__ void counting_sort(int *arr, int *output, int *count, int n, int exp) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        atomicAdd(&count[(arr[i] / exp) % 10], 1);
    }
    __syncthreads();
    for (int i = 1; i < 10; i++) {
        count[i] += count[i - 1];
    }
    __syncthreads();
    if (i < n) {
        int pos = atomicSub(&count[(arr[i] / exp) % 10], 1);
        output[pos - 1] = arr[i];
    }
}

void radix_sort(int *arr, int n) {
    int *d_arr, *d_output, *d_count;
    cudaMalloc((void **)&d_arr, n * sizeof(int));
    cudaMalloc((void **)&d_output, n * sizeof(int));
    cudaMalloc((void **)&d_count, 10 * sizeof(int));

    cudaMemcpy(d_arr, arr, n * sizeof(int), cudaMemcpyHostToDevice);

    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max) max = arr[i];
    }

    int exp = 1;
    while (max / exp > 0) {
        cudaMemset(d_count, 0, 10 * sizeof(int));

        counting_sort<<<(n + 255) / 256, 256>>>(d_arr, d_output, d_count, n, exp);
        cudaMemcpy(d_arr, d_output, n * sizeof(int), cudaMemcpyDeviceToDevice);
        exp *= 10;
    }

    cudaMemcpy(arr, d_arr, n * sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(d_arr);
    cudaFree(d_output);
    cudaFree(d_count);
}

int main() {
    int n = 20;
    int *arr = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % n;
    }

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    radix_sort(arr, n);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    printf("Vreme izvršenja: %f ms\n", milliseconds);

    free(arr);
    return 0;
}
