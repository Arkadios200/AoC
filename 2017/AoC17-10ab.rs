use std::fs;
use core::array;
use std::ops::BitXor;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  println!("Part 1 answer: {}", part1(&input));
  println!("Part 2 answer: {}", knot_hash(&input));
}

fn part1(input: &str) -> u32 {
  let dirs = input.split(',').map(|chunk| chunk.parse::<usize>().unwrap());

  const LEN: usize = 256;
  let mut nums: [u32; LEN] = array::from_fn(|i| i as u32);

  let mut skip: usize = 0;
  let mut i: usize = 0;
  for n in dirs {
    let a = (i..i+n).map(|x| x & LEN-1);
    for (w, x) in a.to_owned().rev().take(n/2).zip(a) {
      nums.swap(w, x);
    }

    i = i + n + skip;
    skip += 1;
  }

  nums[0] * nums[1]
}

fn knot_hash(input: &str) -> String {
  let dirs: Vec<usize> = input.as_bytes().into_iter()
    .map(|&x| x as usize)
    .chain([17usize, 31, 73, 47, 23])
    .collect();

  const LEN: usize = 256;
  let mut nums: [u32; LEN] = array::from_fn(|i| i as u32);

  let mut skip: usize = 0;
  let mut i: usize = 0;
  for _ in 1..=64 {
    for &n in &dirs {
      let a = (i..i+n).map(|x| x & LEN-1);
      for (w, x) in a.to_owned().rev().take(n/2).zip(a) {
        nums.swap(w, x);
      }

      i = i + n + skip;
      skip += 1;
    }
  }

  nums.chunks(16).fold(String::new(), |acc, chunk| {
    let n = chunk.into_iter().fold(0, u32::bitxor);
    acc + format!("{n:0>2x}").as_str()
  })
}