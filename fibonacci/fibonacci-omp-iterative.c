#include <stdio.h>
#include <omp.h>
#include <time.h>

void fib_iter(int n, long *rezultat) {
    long a = 0, b = 1;
    #pragma omp parallel for num_threads(32)
    for (int i = 2; i <= n; i++) {
        long temp = a;
        a = b;
        b = temp + b;
    }
    *rezultat = a;
}

int main() {
    int n = 40;
    long rezultat;

    clock_t start = clock();

    fib_iter(n, &rezultat);

    clock_t end = clock();
    double vreme = (double)(end - start) * 1000 / CLOCKS_PER_SEC;

    printf("Fibonacci od %d je %ld\n", n, rezultat);
    printf("Vreme izvršenja: %.2f ms\n", vreme);
    return 0;
}
