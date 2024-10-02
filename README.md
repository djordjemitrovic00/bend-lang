# Rezultati testiranja algoritama

## 1. Bitonic Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [bitonic-sort/bitonic-sort.rs](./bitonic-sort/bitonic-sort.rs)     | Sekvencijalna | x ms            |         |
| C         | [bitonic-sort/bitonic-sort.c](./bitonic-sort/bitonic-sort.c)     | Paralelna    | x ms            |         |
| CUDA      | [bitonic-sort/bitonic-sort.cu](./bitonic-sort/bitonic-sort.cu)    | Paralelna    | x ms            |         |

## 2. Bubble Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [bubble-sort/bubble-sort.rs](./bubble-sort/bubble-sort.rs)     | Sekvencijalna | x ms            |         |
| C         | [bubble-sort/bubble-sort.c](./bubble-sort/bubble-sort.c)     | Paralelna    | x ms            |         |
| CUDA      | [bubble-sort/bubble-sort.cu](./bubble-sort/bubble-sort.cu)     | Paralelna    | x ms            |         |
| Rust      | [bubble-sort/bubble-sort-with-break.rs](./bubble-sort/bubble-sort-with-break.rs)     | Ubrzana sekvencijalna | x ms            |        |
| C         | [bubble-sort/bubble-sort-with-break.c](./bubble-sort/bubble-sort-with-break.c)     | Dodatno paralelizovana      | x ms            |        |

## 3. Fibonacci

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [fibonacci/fibonacci-seq-recursive.rs](./fibonacci/fibonacci-seq-recursive.rs)     | Sekvencijalna rekurzivna | x ms            |         |
| C         | [fibonacci/fibonacci-omp-recursive.c](./fibonacci/fibonacci-omp-recursive.c)     | Paralelna rekurzivna    | x ms            |         |
| CUDA      | [fibonacci/fibonacci-cu-recursive.cu](./fibonacci/fibonacci-cu-recursive.cu)     | Paralelna rekurzivna   | x ms            |         |
| Rust      | [fibonacci/fibonacci-seq-iterative.rs](./fibonacci/fibonacci-seq-iterative.rs)     | Sekvencijalna iterativna | x ms            |        |
| C         | [fibonacci/fibonacci-omp-iterative.c](./fibonacci/fibonacci-omp-iterative.c)     | Paralelna iterativna      | x ms            |        |
| CUDA      | [fibonacci/fibonacci-cu-iterative.cu](./fibonacci/fibonacci-cu-iterative.cu)     | Paralelna iterativna      | x ms            |        |

## 4. Quick-Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [quick-sort/quick-sort.rs](./quick-sort/quick-sort.rs)     | Sekvencijalna | x ms            |         |
| C         | [quick-sort/quick-sort.c](./quick-sort/quick-sort.c)     | Paralelna    | x ms            |         |
| CUDA      | [quick-sort/quick-sort.cu](./quick-sort/quick-sort.cu)     | Paralelna    | x ms            |         |

## 5. Radix Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [radix-sort/radix-sort.rs](./radix-sort/radix-sort.rs)     | Sekvencijalna | x ms            |         |
| C         | [radix-sort/radix-sort.c](./radix-sort/radix-sort.c)     | Paralelna    | x ms            |         |
| CUDA      | [radix-sort/radix-sort.cu](./radix-sort/radix-sort.cu)     | Paralelna    | x ms            |         |

## 6. Sumiranje prvih milion brojeva

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [sum-milion/sum-milion-dq.rs](./sum-milion/sum-milion-dq.rs)     | Sekvencijalna (Divide and conquer algoritam) | x ms            |         |
| C         | [sum-milion/sum-milion-dq.c](./sum-milion/sum-milion-dq.c)     | Paralelna (Divide and conquer algoritam)    | x ms            |         |
| CUDA      | [sum-milion/sum-milion.cu](./sum-milion/sum-milion.cu)     | Paralelna    | x ms            |         |
| Rust      | [sum-milion/sum-milion-seq.rs](./sum-milion/sum-milion-seq.rs)     | Sekvencijalna iterativna | x ms            |        |
| C         | [sum-milion/sum-milion-omp.c](./sum-milion/sum-milion-omp.c)     | Paralelna iterativna      | x ms            |        |

## 7. Sumiranje elemenata stabla

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [tree-sum-parallel/tree-sum-parallel.rs](./tree-sum-parallel/tree-sum-parallel.rs)     | Sekvencijalna | x ms            |         |
| C         | [tree-sum-parallel/tree-sum-parallel.c](./tree-sum-parallel/tree-sum-parallel.c)     | Paralelna    | x ms            |         |
| CUDA      | [tree-sum-parallel/tree-sum-parallel.cu](./tree-sum-parallel/tree-sum-parallel.cu)     | Paralelna    | x ms            |         |
---

Svi prikazani rezultati su merili vreme izvršenja u milisekundama (`ms`), uz korišćenje raspoloživih resursa za maksimalne performanse u svakom okruženju.
