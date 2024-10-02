use std::time::Instant;

fn quicksort(arr: &mut [i32]) {
    if arr.len() <= 1 {
        return;
    }
    let pivot = arr[arr.len() / 2];
    let (left, right) = arr.split_at_mut(arr.len() / 2);
    let mut lft = 0;
    let mut rgt = right.len();

    while lft < right.len() && rgt > 0 {
        while left[lft] < pivot {
            lft += 1;
        }
        while right[rgt - 1] > pivot {
            rgt -= 1;
        }
        if lft < rgt {
            left.swap(lft, rgt - 1);
        }
    }

    quicksort(&mut left[0..lft]);
    quicksort(&mut right[rgt..]);
}

fn main() {
    let mut arr = (0..14).map(|_| rand::random::<i32>()).collect::<Vec<i32>>();
    let start = Instant::now();
    quicksort(&mut arr);
    let duration = start.elapsed();
    println!("Vreme izvršenja: {} ms", duration.as_millis());
}
