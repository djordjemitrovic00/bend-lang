use std::time::Instant;

fn gen(depth: u64, x: u64) -> (u64, u64) {
    if depth == 0 {
        (x, x)
    } else {
        let left = gen(depth - 1, x * 2);
        let right = gen(depth - 1, x * 2 + 1);
        (left.0, right.1)
    }
}

fn sum(depth: u64, t: (u64, u64)) -> u64 {
    if depth == 0 {
        t.0
    } else {
        let (a, b) = t;
        sum(depth - 1, (a, a)) + sum(depth - 1, (b, b))
    }
}

fn swap(s: bool, a: u64, b: u64) -> (u64, u64) {
    if s {
        (b, a)
    } else {
        (a, b)
    }
}

fn warp(depth: u64, s: bool, a: (u64, u64), b: (u64, u64)) -> ((u64, u64), (u64, u64)) {
    if depth == 0 {
        let (a, b) = swap(s ^ (a.0 > b.0), a.0, b.0);
        ((a, b), (a, b))
    } else {
        let ((a_a, a_b), (b_a, b_b)) = (a, b);
        let (a1, b1) = warp(depth - 1, s, (a_a, a_b), (b_a, b_b));
        ((a1.0, a1.1), (b1.0, b1.1))
    }
}

fn flow(depth: u64, s: bool, t: (u64, u64)) -> (u64, u64) {
    if depth == 0 {
        t
    } else {
        let (a, b) = t;
        let sorted = warp(depth - 1, s, (a, a), (b, b));
        down(depth - 1, s, sorted.0, sorted.1)
    }
}

fn down(depth: u64, s: bool, left: (u64, u64), right: (u64, u64)) -> (u64, u64) {
    if depth == 0 {
        (left.0, right.1)
    } else {
        let left_sorted = flow(depth - 1, s, left);
        let right_sorted = flow(depth - 1, s, right);
        (left_sorted.0, right_sorted.1)
    }
}

fn sort(depth: u64, s: bool, t: (u64, u64)) -> (u64, u64) {
    if depth == 0 {
        t
    } else {
        let (a, b) = t;
        let sorted_left = sort(depth - 1, false, (a, a));
        let sorted_right = sort(depth - 1, true, (b, b));
        flow(depth, s, (sorted_left.0, sorted_right.1))
    }
}

fn main() {
    let start_time = Instant::now();
    
    let t = gen(18, 0);
    let result = sum(18, sort(18, false, t));
    
    let duration = start_time.elapsed();
    println!("Rezultat: {}", result);
    println!("Vreme izvršenja: {} ms", duration.as_millis());
}
