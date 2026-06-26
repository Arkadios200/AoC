use std::fs;
use itertools::Itertools;
use std::ops::Sub;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let reports: Vec<Report> = input.lines().map(process).collect();

  println!("Part 1 answer: {}", reports.iter().filter(|r| r.is_safe(0)).count());
  println!("Part 2 answer: {}", reports.iter().filter(|r| r.is_safe(1)).count());
}

fn process(line: &str) -> Report {
  Report {
    values: line.split(' ').map(|s| s.parse().unwrap()).collect(),
  }
}

#[derive(Debug, Clone)]
struct Report {
  values: Vec<i32>,
}

impl Report {
  fn is_safe(&self, tolerance: u32) -> bool {
    let sign =  if self.values[0] < self.values[1] { 1 } else { -1 };

    let mut check = 0;
    for (a, b) in self.values.iter().map(|n| n * sign).tuple_windows() {
      if !(1..=3).contains(&b.sub(a)) {
        check += 1;
        if check > tolerance { return false; }
      }
    }

    true
  }
}