#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

__global__ void bubble_sort(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        int idx = blockIdx.x * blockDim.x + threadIdx.x;
        if (idx < n - i - 1 && arr[idx] > arr[idx + 1]) {
            int temp = arr[idx];
            arr[idx] = arr[idx + 1];
            arr[idx + 1] = temp;
        }
        __syncthreads();
    }
}

int main() {
    int n = 100;
    int *h_arr = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        h_arr[i] = rand() % 100;
    }

    int *d_arr;
    cudaMalloc(&d_arr, n * sizeof(int));
    cudaMemcpy(d_arr, h_arr, n * sizeof(int), cudaMemcpyHostToDevice);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    bubble_sort<<<32, 512>>>(d_arr, n);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    cudaMemcpy(h_arr, d_arr, n * sizeof(int), cudaMemcpyDeviceToHost);
    
    printf("Vreme izvršenja: %f ms\n", milliseconds);

    cudaFree(d_arr);
    free(h_arr);
    return 0;
}
