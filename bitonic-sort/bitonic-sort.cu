#include <cuda_runtime.h>
#include <iostream>
#include <math.h>

#define N 18
#define THREADS_PER_BLOCK 256

__device__ void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

__device__ void bitonicMerge(int *data, int low, int cnt, int dir)
{
    if (cnt > 1)
    {
        int k = cnt / 2;
        for (int i = low; i < low + k; i++)
        {
            if (dir == (data[i] > data[i + k]))
            {
                swap(&data[i], &data[i + k]);
            }
        }
        bitonicMerge(data, low, k, dir);
        bitonicMerge(data, low + k, k, dir);
    }
}

__global__ void bitonicSortKernel(int *data, int j, int k)
{
    unsigned int i = threadIdx.x + blockDim.x * blockIdx.x;
    unsigned int ixj = i ^ j;

    if (ixj > i)
    {
        if ((i & k) == 0)
        {
            if (data[i] > data[ixj])
            {
                swap(&data[i], &data[ixj]);
            }
        }
        else
        {
            if (data[i] < data[ixj])
            {
                swap(&data[i], &data[ixj]);
            }
        }
    }
}

void bitonicSort(int *data, int n)
{
    int *d_data;
    size_t size = n * sizeof(int);

    cudaMalloc(&d_data, size);
    cudaMemcpy(d_data, data, size, cudaMemcpyHostToDevice);

    dim3 blocks(N / THREADS_PER_BLOCK, 1);
    dim3 threads(THREADS_PER_BLOCK, 1);

    for (int k = 2; k <= N; k <<= 1)
    {
        for (int j = k >> 1; j > 0; j >>= 1)
        {
            bitonicSortKernel<<<blocks, threads>>>(d_data, j, k);
            cudaDeviceSynchronize();
        }
    }

    cudaMemcpy(data, d_data, size, cudaMemcpyDeviceToHost);
    cudaFree(d_data);
}

int main()
{
    int *data = new int[N];

    for (int i = 0; i < N; i++)
    {
        data[i] = rand() % 1000;
    }

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    bitonicSort(data, N);

    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);

    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, start, stop);
    std::cout << "Vreme izvrsenja: " << elapsedTime << " ms" << std::endl;

    std::cout << "Sortiran niz: ";
    for (int i = 0; i < N; i++)
    {
        std::cout << data[i] << " ";
    }
    std::cout << std::endl;

    delete[] data;
    return 0;
}
