enum MyTree {
    Node { val: i32, left: Box<MyTree>, right: Box<MyTree> },
    Leaf,
}

fn sum(tree: &MyTree) -> i32 {
    match tree {
        MyTree::Node { val, left, right } => val + sum(left) + sum(right),
        MyTree::Leaf => 0,
    }
}

fn gen(depth: i32, val: i32) -> MyTree {
    if depth == 0 {
        MyTree::Leaf
    } else {
        MyTree::Node {
            val,
            left: Box::new(gen(depth - 1, 2 * val)),
            right: Box::new(gen(depth - 1, 2 * val + 1)),
        }
    }
}

fn main() {
    let start_time = std::time::Instant::now();
    let tree = gen(14, 1);
    let result = sum(&tree);
    let duration = start_time.elapsed();
    println!("Rezultat: {}", result);
    println!("Vreme izvršenja: {} ms", duration.as_millis());
}
