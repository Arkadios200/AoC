use std::fs;
use std::collections::HashSet;

fn redistribute(banks: &mut Vec<u32>) -> usize {
  let mut record: HashSet<Vec<u32>> = HashSet::new();

  let len = banks.len();
  while record.insert(banks.to_owned()) {
    let (i, e) = banks.to_owned().into_iter().enumerate()
    .max_by(|(i, a), (j, b)| {
      if a == b {
        j.cmp(&i)
      } else { 
        a.cmp(&b)
      }
    }).unwrap();

    banks[i] = 0;

    for x in 1..=e as usize {
      banks[(i + x) % len] += 1;
    }
  }

  record.len()
}

fn main() {
  let input: String = fs::read_to_string("input.txt").unwrap();
  let mut banks: Vec<u32> = input.split_whitespace().map(|n| n.parse().unwrap()).collect();

  println!("Part 1 answer: {}", redistribute(&mut banks));
  println!("Part 2 answer: {}", redistribute(&mut banks));
}
