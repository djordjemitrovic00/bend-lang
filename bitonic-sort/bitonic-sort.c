#include <stdio.h>
#include <omp.h>

void gen(int depth, int x, int *a, int *b) {
    if (depth == 0) {
        *a = x;
        *b = x;
    } else {
        gen(depth - 1, x * 2 + 1, a, b);
        gen(depth - 1, x * 2, a, b);
    }
}

int sum(int depth, int a, int b) {
    if (depth == 0) {
        return a;
    } else {
        return sum(depth - 1, a, a) + sum(depth - 1, b, b);
    }
}

void swap(int s, int *a, int *b) {
    if (s) {
        int temp = *a;
        *a = *b;
        *b = temp;
    }
}

void warp(int depth, int s, int *a_a, int *a_b, int *b_a, int *b_b) {
    if (depth == 0) {
        swap(s + (*a_a > *b_a), a_a, b_a);
    } else {
        warp(depth - 1, s, a_a, a_b, b_a, b_b);
        warp(depth - 1, s, a_b, a_b, b_b, b_b);
    }
}

void sort(int depth, int s, int *a, int *b) {
    if (depth == 0) {
        return;
    } else {
        #pragma omp parallel sections num_threads(32)
        {
            #pragma omp section
            sort(depth - 1, 0, a, b);
            #pragma omp section
            sort(depth - 1, 1, a, b);
        }
        warp(depth, s, a, a, b, b);
    }
}

int main() {
    int a, b;
    int n = 18;
    gen(n, 0, &a, &b);
    
    double start = omp_get_wtime();
    int result = sum(n, a, b);
    double end = omp_get_wtime();
    
    printf("Result: %d\n", result);
    printf("Time taken: %f seconds\n", end - start);
    
    return 0;
}
