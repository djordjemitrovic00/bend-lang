use std::time::Instant;

fn fib(n: u32) -> u32 {
    match n {
        0 => 0,
        1 => 1,
        _ => fib(n - 1) + fib(n - 2),
    }
}

fn main() {
    let start = Instant::now();
    let rezultat = fib(40);
    let vreme = start.elapsed();
    println!("Fibonacci od 40: {}", rezultat);
    println!("Vreme izvršenja: {} ms", vreme.as_millis());
}
