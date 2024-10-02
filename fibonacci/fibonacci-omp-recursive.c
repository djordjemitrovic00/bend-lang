#include <stdio.h>
#include <omp.h>
#include <time.h>

int fib(int n) {
    if (n <= 1)
        return n;
    else {
        int x, y;
        #pragma omp task shared(x)
        x = fib(n - 1);
        #pragma omp task shared(y)
        y = fib(n - 2);
        #pragma omp taskwait
        return x + y;
    }
}

int main() {
    int n = 40;
    int rezultat;
    clock_t start = clock();

    #pragma omp parallel num_threads(32)
    {
        #pragma omp single
        rezultat = fib(n);
    }

    clock_t end = clock();
    double vreme = (double)(end - start) * 1000 / CLOCKS_PER_SEC;

    printf("Fibonacci od %d je %d\n", n, rezultat);
    printf("Vreme izvršenja: %.2f ms\n", vreme);
    return 0;
}
