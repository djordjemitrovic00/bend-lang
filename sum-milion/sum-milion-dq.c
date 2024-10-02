#include <stdio.h>
#include <omp.h>

long long sum_recursive(int start, int target) {
    if (start == target) {
        return start;
    } else {
        int half = (start + target) / 2;
        long long left, right;

        #pragma omp task shared(left)
        left = sum_recursive(start, half);

        #pragma omp task shared(right)
        right = sum_recursive(half + 1, target);

        #pragma omp taskwait

        return left + right;
    }
}

int main() {
    int start = 1;
    int target = 1000000;
    long long result;

    double start_time = omp_get_wtime();

    #pragma omp parallel
    {
        #pragma omp single
        {
            result = sum_recursive(start, target);
        }
    }

    double end_time = omp_get_wtime();

    printf("Suma prvih %d brojeva je: %lld\n", target, result);
    printf("Vreme izvršenja: %f sekundi\n", end_time - start_time);

    return 0;
}