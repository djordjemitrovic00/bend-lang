fn radix_sort(arr: &mut Vec<u32>) {
    let mut max = *arr.iter().max().unwrap();
    let mut exp = 1;
    while max / exp > 0 {
        counting_sort(arr, exp);
        exp *= 10;
    }
}

fn counting_sort(arr: &mut Vec<u32>, exp: u32) {
    let mut output = vec![0; arr.len()];
    let mut count = vec![0; 10];

    for &num in arr.iter() {
        count[((num / exp) % 10) as usize] += 1;
    }

    for i in 1..10 {
        count[i] += count[i - 1];
    }

    for &num in arr.iter().rev() {
        let idx = ((num / exp) % 10) as usize;
        count[idx] -= 1;
        output[count[idx]] = num;
    }

    arr.copy_from_slice(&output);
}

fn main() {
    let mut arr = (0..20).map(|_| rand::random::<u32>() % 20).collect::<Vec<u32>>();
    let start_time = std::time::Instant::now();
    radix_sort(&mut arr);
    let duration = start_time.elapsed();
    println!("Vreme izvršenja: {} ms", duration.as_millis());
}
