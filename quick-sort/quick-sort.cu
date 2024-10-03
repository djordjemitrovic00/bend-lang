#include <stdio.h>
#include <cuda_runtime.h>

__device__ int partition(int *arr, int left, int right)
{
    int pivot = arr[right];
    int i = left - 1;
    for (int j = left; j < right; j++)
    {
        if (arr[j] <= pivot)
        {
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

__global__ void quicksort_kernel(int *arr, int *lefts, int *rights, int size)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < size)
    {
        int left = lefts[idx];
        int right = rights[idx];
        if (left < right)
        {
            int pivot = partition(arr, left, right);

            if (pivot - 1 > left)
            {
                lefts[idx] = left;
                rights[idx] = pivot - 1;
            }
            else
            {
                lefts[idx] = pivot + 1;
                rights[idx] = right;
            }
        }
    }
}

void quicksort_host(int *arr, int n)
{
    int *d_arr, *d_lefts, *d_rights;
    int *lefts = (int *)malloc(n * sizeof(int));
    int *rights = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++)
    {
        lefts[i] = 0;
        rights[i] = n - 1;
    }

    cudaMalloc((void **)&d_arr, n * sizeof(int));
    cudaMalloc((void **)&d_lefts, n * sizeof(int));
    cudaMalloc((void **)&d_rights, n * sizeof(int));

    cudaMemcpy(d_arr, arr, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_lefts, lefts, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_rights, rights, n * sizeof(int), cudaMemcpyHostToDevice);

    int blockSize = 256;
    int gridSize = (n + blockSize - 1) / blockSize;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    for (int step = 0; step < n; step++)
    {
        quicksort_kernel<<<gridSize, blockSize>>>(d_arr, d_lefts, d_rights, n);
        cudaDeviceSynchronize();
    }

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    cudaMemcpy(arr, d_arr, n * sizeof(int), cudaMemcpyDeviceToHost);

    printf("Vreme izvršenja: %f ms\n", milliseconds);

    cudaFree(d_arr);
    cudaFree(d_lefts);
    cudaFree(d_rights);
    free(lefts);
    free(rights);
}

int main()
{
    int n = 14;
    int *arr = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++)
    {
        arr[i] = rand() % n;
    }

    quicksort_host(arr, n);

    printf("Sortirani niz: ");
    for (int i = 0; i < n; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(arr);
    return 0;
}
