use std::time::Instant;

fn fib(n: u32) -> u32 {
    let mut a = 0;
    let mut b = 1;
    for _ in 0..n {
        let temp = a;
        a = b;
        b = temp + b;
    }
    a
}

fn main() {
    let start = Instant::now();
    let rezultat = fib(40);
    let vreme = start.elapsed();
    println!("Fibonacci od 40: {}", rezultat);
    println!("Vreme izvršenja: {} ms", vreme.as_millis());
}
