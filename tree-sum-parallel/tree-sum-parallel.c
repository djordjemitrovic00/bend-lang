#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

typedef struct MyTree {
    int val;
    struct MyTree *left, *right;
} MyTree;

MyTree* gen(int depth, int val) {
    if (depth == 0) {
        return NULL;
    } else {
        MyTree *node = (MyTree *)malloc(sizeof(MyTree));
        node->val = val;
        #pragma omp task shared(node)
        node->left = gen(depth - 1, 2 * val);
        #pragma omp task shared(node)
        node->right = gen(depth - 1, 2 * val + 1);
        #pragma omp taskwait
        return node;
    }
}

int sum(MyTree *tree) {
    if (tree == NULL) {
        return 0;
    } else {
        int left_sum, right_sum;
        #pragma omp task shared(left_sum)
        left_sum = sum(tree->left);
        #pragma omp task shared(right_sum)
        right_sum = sum(tree->right);
        #pragma omp taskwait
        return tree->val + left_sum + right_sum;
    }
}

int main() {
    int depth = 14;
    double start_time = omp_get_wtime();
    MyTree *tree = NULL;
    #pragma omp parallel
    {
        #pragma omp single
        tree = gen(depth, 1);
    }
    int result = 0;
    #pragma omp parallel
    {
        #pragma omp single
        result = sum(tree);
    }
    double end_time = omp_get_wtime();
    printf("Rezultat: %d\n", result);
    printf("Vreme izvršenja: %f ms\n", (end_time - start_time) * 1000);
    return 0;
}
