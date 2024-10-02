#include <stdio.h>
#include <cuda_runtime.h>

__global__ void fib_iter(long *rezultat, int n) {
    long a = 0, b = 1;
    for (int i = 2; i <= n; i++) {
        long temp = a;
        a = b;
        b = temp + b;
    }
    *rezultat = a;
}

int main() {
    int n = 40;
    long h_rezultat;
    long *d_rezultat;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaMalloc(&d_rezultat, sizeof(long));

    cudaEventRecord(start);
    fib_iter<<<1024, 16>>>(d_rezultat, n);
    cudaEventRecord(stop);

    cudaMemcpy(&h_rezultat, d_rezultat, sizeof(long), cudaMemcpyDeviceToHost);
    cudaFree(d_rezultat);

    cudaEventSynchronize(stop);
    float vreme = 0;
    cudaEventElapsedTime(&vreme, start, stop);

    printf("Fibonacci od %d je %ld\n", n, h_rezultat);
    printf("Vreme izvršenja: %.2f ms\n", vreme);
    return 0;
}
