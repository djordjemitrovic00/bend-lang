#include <stdio.h>
#include <cuda_runtime.h>

__global__ void sum_reduce(int* input, unsigned long long* output, int n) {
    extern __shared__ int shared_data[];

    int tid = threadIdx.x;
    int global_id = blockIdx.x * blockDim.x + threadIdx.x;

    shared_data[tid] = (global_id < n) ? input[global_id] : 0;
    __syncthreads();

    for (int stride = blockDim.x / 2; stride > 0; stride >>= 1) {
        if (tid < stride) {
            shared_data[tid] += shared_data[tid + stride];
        }
        __syncthreads();
    }

    if (tid == 0) {
        atomicAdd(output, (unsigned long long)shared_data[0]);
    }
}

int main() {
    int n = 1000000;
    int block_size = 256;
    int grid_size = (n + block_size - 1) / block_size;

    int* h_input = (int*)malloc(n * sizeof(int));
    unsigned long long h_output = 0;

    for (int i = 0; i < n; i++) {
        h_input[i] = i + 1;
    }

    int* d_input;
    unsigned long long* d_output;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    
    cudaMalloc((void**)&d_input, n * sizeof(int));
    cudaMalloc((void**)&d_output, sizeof(unsigned long long));

    cudaMemcpy(d_input, h_input, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_output, &h_output, sizeof(unsigned long long), cudaMemcpyHostToDevice);

    sum_reduce<<<grid_size, block_size, block_size * sizeof(int)>>>(d_input, d_output, n);
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);

    cudaMemcpy(&h_output, d_output, sizeof(unsigned long long), cudaMemcpyDeviceToHost);

    printf("Suma prvih %d prirodnih brojeva je: %llu\n", n, h_output);

    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("Vreme izvršenja na GPU: %f ms\n", milliseconds);

    free(h_input);
    cudaFree(d_input);
    cudaFree(d_output);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return 0;
}
