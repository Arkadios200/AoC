use std::fs;
use std::iter::zip;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  println!("Part 1 answer: {}", part1(&input));
  println!("Part 2 answer: {}", knot_hash(&input));
}

fn part1(input: &str) -> u32 {
  let dirs = input.split(',').map(|chunk| chunk.parse::<usize>().unwrap());

  let mut nums: Vec<u32> = (0..256).collect();
  let len = nums.len();

  let mut skip: usize = 0;
  let mut i: usize = 0;
  for n in dirs {
    let a = (i..i+n).map(|x| x % len);
    let b = a.to_owned().map(|k| nums[k]).rev().collect::<Vec<u32>>();
    for (j, e) in zip(a, b) {
      nums[j] = e;
    }

    i = (i + n + skip) % len;
    skip += 1;
  }

  nums[0] * nums[1]
}

fn knot_hash(input: &str) -> String {
  let dirs: Vec<usize> = input.as_bytes().into_iter()
    .map(|&x| x as usize)
    .chain([17, 31, 73, 47, 23])
    .collect();

  let mut nums: Vec<u32> = (0..256).collect();
  let len = nums.len();

  let mut skip: usize = 0;
  let mut i: usize = 0;

  for _ in 1..=64 {
    for &n in dirs.iter() {
      let rng = (i..i+n).map(|x| x % len);
      let a: Vec<u32> = rng.to_owned().map(|x| nums[x]).collect();
      
      for (j, e) in zip(rng.rev(), a) {
        nums[j] = e;
      }

      i = (i + n + skip) % len;
      skip += 1;
    }
  }

  nums.chunks(16).fold(String::new(), |acc, chunk| {
    let s = format!("{:x}", chunk.into_iter().fold(0, |acc, num| acc ^ num));
    acc + if s.len() == 1 { format!("0{s}") } else { s }.as_str()
  })
}