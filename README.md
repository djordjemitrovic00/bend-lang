# Rezultati testiranja algoritama

## 1. Bitonic Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [bitonic-sort/bitonic-sort.rs](./bitonic-sort/bitonic-sort.rs)     | Sekvencijalna | 25 ms            | Mora da se koristi u64 tip da ne dodje do overflow        |
| C         | [bitonic-sort/bitonic-sort.c](./bitonic-sort/bitonic-sort.c)     | Paralelna    | 2 ms            |         |
| CUDA      | [bitonic-sort/bitonic-sort.cu](./bitonic-sort/bitonic-sort.cu)    | Paralelna    | 8.94157 ms            |         |

## 2. Bubble Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [bubble-sort/bubble-sort.rs](./bubble-sort/bubble-sort.rs)     | Sekvencijalna | 0 ms            |         |
| C         | [bubble-sort/bubble-sort.c](./bubble-sort/bubble-sort.c)     | Paralelna    | 4204.51 ms            |         |
| CUDA      | [bubble-sort/bubble-sort.cu](./bubble-sort/bubble-sort.cu)     | Paralelna    | 12.145664 ms            |         |
| Rust      | [bubble-sort/bubble-sort-with-break.rs](./bubble-sort/bubble-sort-with-break.rs)     | Ubrzana sekvencijalna | 0 ms            |        |
| C         | [bubble-sort/bubble-sort-with-break.c](./bubble-sort/bubble-sort-with-break.c)     | Dodatno paralelizovana      | 2407.18 ms            |        |

## 3. Fibonacci

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [fibonacci/fibonacci-seq-recursive.rs](./fibonacci/fibonacci-seq-recursive.rs)     | Sekvencijalna rekurzivna | 961 ms            |         |
| C         | [fibonacci/fibonacci-omp-recursive.c](./fibonacci/fibonacci-omp-recursive.c)     | Paralelna rekurzivna    | 5206794.40 ms            |         |
| CUDA      | [fibonacci/fibonacci-cu-recursive.cu](./fibonacci/fibonacci-cu-recursive.cu)     | Paralelna rekurzivna   | 53058.22 ms            |         |
| Rust      | [fibonacci/fibonacci-seq-iterative.rs](./fibonacci/fibonacci-seq-iterative.rs)     | Sekvencijalna iterativna | 0 ms            |        |
| C         | [fibonacci/fibonacci-omp-iterative.c](./fibonacci/fibonacci-omp-iterative.c)     | Paralelna iterativna      | 24.96 ms            |        |
| CUDA      | [fibonacci/fibonacci-cu-iterative.cu](./fibonacci/fibonacci-cu-iterative.cu)     | Paralelna iterativna      | 11.48 ms            |        |

## 4. Quick-Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [quick-sort/quick-sort.rs](./quick-sort/quick-sort.rs)     | Sekvencijalna | 0 ms            |         |
| C         | [quick-sort/quick-sort.c](./quick-sort/quick-sort.c)     | Paralelna    | 17.168171 ms            |         |
| CUDA      | [quick-sort/quick-sort.cu](./quick-sort/quick-sort.cu)     | Paralelna    | 12.688416 ms            |         |

## 5. Radix Sort

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [radix-sort/radix-sort.rs](./radix-sort/radix-sort.rs)     | Sekvencijalna | 0 ms            |         |
| C         | [radix-sort/radix-sort.c](./radix-sort/radix-sort.c)     | Paralelna    | 4.176069 ms            |          |
| CUDA      | [radix-sort/radix-sort.cu](./radix-sort/radix-sort.cu)     | Paralelna    | 13.073792 ms            |         |

## 6. Sumiranje prvih milion brojeva

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [sum-milion/sum-milion-dq.rs](./sum-milion/sum-milion-dq.rs)     | Sekvencijalna (Divide and conquer algoritam) | 15.921487 ms            |         |
| C         | [sum-milion/sum-milion-dq.c](./sum-milion/sum-milion-dq.c)     | Paralelna (Divide and conquer algoritam)    | 20.910055 ms            |         |
| CUDA      | [sum-milion/sum-milion.cu](./sum-milion/sum-milion.cu)     | Paralelna    | 10.519520 ms            |         |
| Rust      | [sum-milion/sum-milion-seq.rs](./sum-milion/sum-milion-seq.rs)     | Sekvencijalna iterativna | 18.114958 ms            |        |
| C         | [sum-milion/sum-milion-omp.c](./sum-milion/sum-milion-omp.c)     | Paralelna iterativna      | 4.469 ms            |        |

## 7. Sumiranje elemenata stabla

| Okruženje | Fajl | Verzija      | Vreme izvršenja | NAPOMENA |
|-----------|------|--------------|-----------------|----------|
| Rust      | [tree-sum-parallel/tree-sum-parallel.rs](./tree-sum-parallel/tree-sum-parallel.rs)     | Sekvencijalna | 3 ms            |         |
| C         | [tree-sum-parallel/tree-sum-parallel.c](./tree-sum-parallel/tree-sum-parallel.c)     | Paralelna    | 16.389889 ms            |         |
| CUDA      | [tree-sum-parallel/tree-sum-parallel.cu](./tree-sum-parallel/tree-sum-parallel.cu)     | Paralelna    | 16.389889 ms            |         |
---

Svi prikazani rezultati su merili vreme izvršenja u milisekundama (`ms`), uz korišćenje raspoloživih resursa za maksimalne performanse u svakom okruženju.
