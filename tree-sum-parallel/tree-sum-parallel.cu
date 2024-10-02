#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

struct MyTree {
    int val;
    MyTree *left, *right;
};

__device__ int sum_device(MyTree *tree) {
    if (tree == NULL) {
        return 0;
    } else {
        int left_sum = sum_device(tree->left);
        int right_sum = sum_device(tree->right);
        return tree->val + left_sum + right_sum;
    }
}

__global__ void sum_kernel(MyTree *tree, int *result) {
    *result = sum_device(tree);
}

__global__ MyTree* gen_device(int depth, int val) {
    if (depth == 0) {
        return NULL;
    } else {
        MyTree *node = (MyTree *)malloc(sizeof(MyTree));
        node->val = val;
        node->left = gen_device(depth - 1, 2 * val);
        node->right = gen_device(depth - 1, 2 * val + 1);
        return node;
    }
}

int main() {
    int depth = 14;
    int *d_result, h_result;
    cudaMalloc(&d_result, sizeof(int));

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);

    MyTree *d_tree = NULL;
    gen_device<<<32, 512>>>(depth, 1);
    cudaDeviceSynchronize();

    sum_kernel<<<32, 512>>>(d_tree, d_result);
    cudaMemcpy(&h_result, d_result, sizeof(int), cudaMemcpyDeviceToHost);
    
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    printf("Rezultat: %d\n", h_result);
    printf("Vreme izvršenja: %f ms\n", milliseconds);

    cudaFree(d_result);
    return 0;
}
