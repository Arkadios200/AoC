use std::fs;
use std::iter::zip;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  println!("Part 1 answer: {}", part1(&input));
  println!("Part 2 answer: {}", knot_hash(&input));
}

fn part1(input: &str) -> u32 {
  let dirs = input.split(',').map(|chunk| chunk.parse::<usize>().unwrap());

  let mut nums: [u32; 256] = core::array::from_fn(|i| i as u32);
  let len = nums.len();

  let mut skip: usize = 0;
  let mut i: usize = 0;
  for n in dirs {
    let a = (i..i+n).map(|x| x % len);
    let b = a.to_owned().map(move |k| nums[k]).rev();
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

  let mut nums: [u32; 256] = core::array::from_fn(|i| i as u32);
  let len = nums.len();

  let mut skip: usize = 0;
  let mut i: usize = 0;

  for _ in 1..=64 {
    for &n in dirs.iter() {
      let a = (i..i+n).map(|x| x % len);
      let b = a.to_owned().map(move |k| nums[k]);
      
      for (j, e) in zip(a.rev(), b) {
        nums[j] = e;
      }

      i = (i + n + skip) % len;
      skip += 1;
    }
  }

  nums.chunks(16).fold(String::new(), |acc, chunk| {
    acc + format!("{:0>2x}", chunk.into_iter().fold(0, |acc, num| acc ^ num)).as_str()
  })
}