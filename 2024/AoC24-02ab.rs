use std::fs;
use itertools::Itertools;
use std::ops::Sub;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let reports: Vec<Report> = input.lines().map(Report::from).collect();

  println!("Part 1 answer: {}", reports.iter().filter(|r| r.is_safe(&0)).count());
  println!("Part 2 answer: {}", reports.iter().filter(|r| r.is_safe(&1)).count());
}

struct Report {
  values: Vec<i32>,
}

impl Report {
  fn is_safe(&self, tolerance: &usize) -> bool {
    let sign = if self.values[0] < self.values[1] { 1 } else { -1 };

    self.values.iter()
    .map(|n| n * sign)
    .tuple_windows().filter(|(a, b)| !(1..=3).contains(&b.sub(a)))
    .count().le(tolerance)
  }
}

impl From<&str> for Report {
  fn from(s: &str) -> Self {
    Self {
      values: s.split(' ').map(|s| s.parse().unwrap()).collect(),
    }
  }
}