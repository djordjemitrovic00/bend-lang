#include <stdio.h>
#include <omp.h>

int main() {
    int n = 1000000;
    long long sum = 0;
    int i;

    double start_time = omp_get_wtime();

    #pragma omp parallel for reduction(+:sum) num_threads(32)
    for (i = 1; i <= n; i++) {
        sum += i;
    }

    double end_time = omp_get_wtime();

    printf("Suma prvih %d prirodnih brojeva je: %lld\n", n, sum);
    printf("Vreme izvršenja: %f sekundi\n", end_time - start_time);

    return 0;
}