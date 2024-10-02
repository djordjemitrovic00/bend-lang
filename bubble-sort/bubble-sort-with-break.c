#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

void parallel_bubble_sort(int *arr, int n) {
    int swapped;
    for (int i = 0; i < n - 1; i++) {
        swapped = 0;
        #pragma omp parallel for shared(arr, n)
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                swapped = 1;
            }
        }
        if (!swapped) break;
    }
}

int main() {
    int n = 100;
    int arr[100];
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 100;
    }

    double start_time = omp_get_wtime();
    parallel_bubble_sort(arr, n);
    double end_time = omp_get_wtime();

    printf("Vreme izvršenja: %.2f ms\n", (end_time - start_time) * 1000);
    return 0;
}
