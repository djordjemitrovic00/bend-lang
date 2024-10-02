#include <stdio.h>
#include <cuda_runtime.h>

__global__ void quicksort(int *arr, int left, int right);

__device__ int partition(int *arr, int left, int right) {
    int pivot = arr[right];
    int i = left - 1;
    for (int j = left; j < right; j++) {
        if (arr[j] <= pivot) {
            i++;
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }
    int temp = arr[i + 1];
    arr[i + 1] = arr[right];
    arr[right] = temp;
    return i + 1;
}

__global__ void quicksort(int *arr, int left, int right) {
    if (left < right) {
        int pivot = partition(arr, left, right);

        if (pivot - left > 1024) {
            quicksort<<<32, 32>>>(arr, left, pivot - 1);
        } else {
            quicksort<<<32, 32>>>(arr, pivot + 1, right);
        }
    }
}

int main() {
    int n = 14;
    int *arr, *d_arr;
    arr = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        arr[i] = rand() % n;
    }

    cudaMalloc((void **)&d_arr, n * sizeof(int));
    cudaMemcpy(d_arr, arr, n * sizeof(int), cudaMemcpyHostToDevice);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    quicksort<<<32, 512>>>(d_arr, 0, n - 1);

    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    cudaMemcpy(arr, d_arr, n * sizeof(int), cudaMemcpyDeviceToHost);

    printf("Vreme izvršenja: %f ms\n", milliseconds);

    cudaFree(d_arr);
    free(arr);
    return 0;
}
