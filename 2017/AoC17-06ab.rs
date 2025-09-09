use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let mut banks: Vec<u32> = input.split_whitespace().map(|s| s.parse().unwrap()).collect();

  println!("Part 1 answer: {}", redistribute(&mut banks));
  println!("Part 2 answer: {}", redistribute(&mut banks));
}

fn redistribute(banks: &mut [u32]) -> usize {
  let mut record: HashSet<Vec<u32>> = HashSet::new();

  let len = banks.len();
  while record.insert(banks.to_owned()) {
    let (i, e) = banks.to_owned().into_iter().enumerate().rev().max_by_key(|&(_, n)| n).unwrap();

    banks[i] = 0;
    for n in 1..=e as usize {
      banks[(i + n) % len] += 1;
    }
  }

  record.len()
}