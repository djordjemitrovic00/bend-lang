#include <stdio.h>
#include <cuda_runtime.h>

struct MyTree
{
    int val;
    int left_index;
    int right_index;
};

__global__ void gen_tree(MyTree *nodes, int depth)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int num_nodes = (1 << (depth + 1)) - 1;

    if (idx < num_nodes)
    {
        nodes[idx].val = idx + 1;

        int left_child = 2 * idx + 1;
        int right_child = 2 * idx + 2;

        if (left_child < num_nodes)
        {
            nodes[idx].left_index = left_child;
        }
        else
        {
            nodes[idx].left_index = -1;
        }

        if (right_child < num_nodes)
        {
            nodes[idx].right_index = right_child;
        }
        else
        {
            nodes[idx].right_index = -1;
        }
    }
}

__global__ void sum_tree(MyTree *nodes, int *result, int depth)
{
    __shared__ int shared_sum[1024];

    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int num_nodes = (1 << (depth + 1)) - 1;

    if (idx < num_nodes)
    {
        shared_sum[threadIdx.x] = nodes[idx].val;
    }
    else
    {
        shared_sum[threadIdx.x] = 0;
    }

    __syncthreads();

    for (int stride = blockDim.x / 2; stride > 0; stride >>= 1)
    {
        if (threadIdx.x < stride)
        {
            shared_sum[threadIdx.x] += shared_sum[threadIdx.x + stride];
        }
        __syncthreads();
    }

    if (threadIdx.x == 0)
    {
        atomicAdd(result, shared_sum[0]);
    }
}

int main()
{
    int depth = 14;
    int num_nodes = (1 << (depth + 1)) - 1;
    int *d_result, h_result = 0;
    MyTree *d_tree;

    cudaMalloc(&d_tree, num_nodes * sizeof(MyTree));
    cudaMalloc(&d_result, sizeof(int));
    cudaMemset(d_result, 0, sizeof(int));

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    gen_tree<<<(num_nodes + 1023) / 1024, 1024>>>(d_tree, depth);
    cudaDeviceSynchronize();

    sum_tree<<<(num_nodes + 1023) / 1024, 1024>>>(d_tree, d_result, depth);
    cudaMemcpy(&h_result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    printf("Rezultat: %d\n", h_result);
    printf("Vreme izvršenja: %f ms\n", milliseconds);

    cudaFree(d_tree);
    cudaFree(d_result);
    return 0;
}
