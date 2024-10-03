#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

void counting_sort(int *arr, int n, int exp);
void radix_sort(int *arr, int n);

void counting_sort(int *arr, int n, int exp)
{
    int *output = (int *)malloc(n * sizeof(int));
    int count[10] = {0};

#pragma omp parallel for
    for (int i = 0; i < n; i++)
    {
#pragma omp atomic
        count[(arr[i] / exp) % 10]++;
    }

    for (int i = 1; i < 10; i++)
    {
        count[i] += count[i - 1];
    }

#pragma omp parallel for
    for (int i = n - 1; i >= 0; i--)
    {
        int idx = --count[(arr[i] / exp) % 10];
        output[idx] = arr[i];
    }

#pragma omp parallel for
    for (int i = 0; i < n; i++)
    {
        arr[i] = output[i];
    }

    free(output);
}

void radix_sort(int *arr, int n)
{
    int max = arr[0];

    for (int i = 1; i < n; i++)
    {
        if (arr[i] > max)
            max = arr[i];
    }

    for (int exp = 1; max / exp > 0; exp *= 10)
    {
        counting_sort(arr, n, exp);
    }
}

int main()
{
    int n = 20;
    int *arr = (int *)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++)
    {
        arr[i] = rand() % n;
    }

    double start_time = omp_get_wtime();
    radix_sort(arr, n);
    double end_time = omp_get_wtime();

    printf("Vreme izvršenja: %f ms\n", (end_time - start_time) * 1000);

    for (int i = 0; i < n; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(arr);
    return 0;
}