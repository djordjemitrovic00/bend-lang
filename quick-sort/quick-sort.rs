use std::time::Instant;

fn quicksort(arr: &mut [i32]) {
    if arr.len() <= 1 {
        return;
    }
    let pivot_index = partition(arr);
    let (left, right) = arr.split_at_mut(pivot_index);
    quicksort(left);
    quicksort(&mut right[1..]);
}

fn partition(arr: &mut [i32]) -> usize {
    let pivot = arr[arr.len() - 1];
    let mut i = 0;
    
    for j in 0..arr.len() - 1 {
        if arr[j] < pivot {
            arr.swap(i, j);
            i += 1;
        }
    }
    arr.swap(i, arr.len() - 1);
    i
}

fn main() {
    let mut arr = (0..14).map(|_| rand::random::<i32>()).collect::<Vec<i32>>();
    println!("Originalni niz: {:?}", arr);
    
    let start = Instant::now();
    quicksort(&mut arr);
    let duration = start.elapsed();
    
    println!("Sortirani niz: {:?}", arr);
    println!("Vreme izvršenja: {} ms", duration.as_millis());
}
