#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <time.h>

void quicksort(int *arr, int left, int right);
int partition(int *arr, int left, int right);

void quicksort(int *arr, int left, int right) {
    if (left < right) {
        int pivot = partition(arr, left, right);

        #pragma omp parallel sections
        {
            #pragma omp section
            quicksort(arr, left, pivot - 1);
            #pragma omp section
            quicksort(arr, pivot + 1, right);
        }
    }
}

int partition(int *arr, int left, int right) {
    int pivot = arr[right];
    int i = left - 1;
    for (int j = left; j < right; j++) {
        if (arr[j] <= pivot) {
            i++;
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }
    int temp = arr[i + 1];
    arr[i + 1] = arr[right];
    arr[right] = temp;
    return i + 1;
}

int main() {
    int n = 14;
    int *arr = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % n;
    }

    double start_time = omp_get_wtime();
    quicksort(arr, 0, n - 1);
    double end_time = omp_get_wtime();

    printf("Vreme izvršenja: %f ms\n", (end_time - start_time) * 1000);
    free(arr);
    return 0;
}
