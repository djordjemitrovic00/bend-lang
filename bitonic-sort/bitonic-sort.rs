fn gen(depth: u32, x: u32) -> (u32, u32) {
    if depth == 0 {
        (x, x)
    } else {
        let left = gen(depth - 1, x * 2 + 1);
        let right = gen(depth - 1, x * 2);
        (left.0, right.1)
    }
}

fn sum(depth: u32, t: (u32, u32)) -> u32 {
    if depth == 0 {
        t.0
    } else {
        let (a, b) = t;
        sum(depth - 1, (a, a)) + sum(depth - 1, (b, b))
    }
}

fn swap(s: bool, a: u32, b: u32) -> (u32, u32) {
    if s {
        (b, a)
    } else {
        (a, b)
    }
}

fn warp(depth: u32, s: bool, a: (u32, u32), b: (u32, u32)) -> ((u32, u32), (u32, u32)) {
    if depth == 0 {
        let (a, b) = swap(s ^ (a.0 > b.0), a.0, b.0);
        ((a, b), (a, b))
    } else {
        let ((a_a, a_b), (b_a, b_b)) = (a, b);
        let (a1, b1) = warp(depth - 1, s, (a_a, a_b), (b_a, b_b));
        ((a1.0, b1.0), (a1.1, b1.1))
    }
}

fn flow(depth: u32, s: bool, t: (u32, u32)) -> (u32, u32) {
    if depth == 0 {
        t
    } else {
        let (a, b) = t;
        down(depth, s, warp(depth - 1, s, (a, a), (b, b)))
    }
}

fn down(depth: u32, s: bool, t: (u32, u32)) -> (u32, u32) {
    if depth == 0 {
        t
    } else {
        let (a, b) = t;
        (flow(depth - 1, s, (a, a)), flow(depth - 1, s, (b, b)))
    }
}

fn sort(depth: u32, s: bool, t: (u32, u32)) -> (u32, u32) {
    if depth == 0 {
        t
    } else {
        let (a, b) = t;
        flow(depth, s, (sort(depth - 1, false, a), sort(depth - 1, true, b)))
    }
}

fn main() {
    let t = gen(18, 0);
    let result = sum(18, sort(18, false, t));
    println!("Result: {}", result);
}
