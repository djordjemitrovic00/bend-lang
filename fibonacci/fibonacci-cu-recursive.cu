#include <stdio.h>
#include <cuda_runtime.h>

__device__ int fib(int n) {
    if (n <= 1)
        return n;
    else
        return fib(n - 1) + fib(n - 2);
}

__global__ void fibonacci(int *rezultat, int n) {
    *rezultat = fib(n);
}

int main() {
    int n = 40;
    int h_rezultat;
    int *d_rezultat;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaMalloc(&d_rezultat, sizeof(int));

    cudaEventRecord(start);
    fibonacci<<<1024, 16>>>(d_rezultat, n);
    cudaEventRecord(stop);

    cudaMemcpy(&h_rezultat, d_rezultat, sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(d_rezultat);

    cudaEventSynchronize(stop);
    float vreme = 0;
    cudaEventElapsedTime(&vreme, start, stop);

    printf("Fibonacci od %d je %d\n", n, h_rezultat);
    printf("Vreme izvršenja: %.2f ms\n", vreme);
    return 0;
}
