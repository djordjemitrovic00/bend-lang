fn bubble_sort(arr: &mut [i32]) {
    let len = arr.len();
    let mut swapped;
    for i in 0..len {
        swapped = false;
        for j in 0..len - i - 1 {
            if arr[j] > arr[j + 1] {
                arr.swap(j, j + 1);
                swapped = true;
            }
        }
        if !swapped {
            break;
        }
    }
}

fn main() {
    let mut arr: Vec<i32> = (1..101).collect();
    arr.shuffle(&mut rand::thread_rng());

    let start_time = std::time::Instant::now();
    bubble_sort(&mut arr);
    let duration = start_time.elapsed();

    println!("Vreme izvršenja: {} ms", duration.as_millis());
}
