use std::time::Instant;

fn sequential_sum(start: usize, end: usize) -> usize {
    (start..=end).sum()
}

fn main() {
    let start = 1;
    let end = 1_000_000;

    let start_time = Instant::now();

    let sum = sequential_sum(start, end);

    let duration = start_time.elapsed();

    println!("Suma prvih {} brojeva je: {}", end, sum);
    println!("Vreme izvršenja: {:?}", duration);
}
