use std::time::Instant;
// divide and conquer
fn sum(start: usize, target: usize) -> usize {
    if start == target {
        return start;
    } else {
        let half = (start + target) / 2;
        let left = sum(start, half);
        let right = sum(half + 1, target);
        return left + right;
    }
}

fn main() {
    let start = 1;
    let target = 1_000_000;

    let start_time = Instant::now();

    let result = sum(start, target);

    let duration = start_time.elapsed();

    println!("Suma brojeva od {} do {} je: {}", start, target, result);
    println!("Vreme izvršenja: {:?}", duration);
}
