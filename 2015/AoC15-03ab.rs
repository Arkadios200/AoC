use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let ans1 = part1(&input);
  println!("Part 1 answer: {ans1}");

  let ans2 = part2(&input);
  println!("Part 2 answer: {ans2}");
}

fn part1(input: &str) -> usize {
  let mut record: HashSet<Point> = HashSet::new();
  let mut pos = Point::new();
  record.insert(pos);

  for c in input.chars() {
    record.insert(pos.step(c));
  }

  record.len()
}

fn part2(input: &str) -> usize {
  let mut record: HashSet<Point> = HashSet::new();
  let mut pos: [Point; 2] = [Point::new(), Point::new()];
  record.insert(pos[0]);

  for (i, c) in input.chars().enumerate() {
    record.insert(pos[i % 2].step(c));
  }

  record.len()
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32
}

impl Point {
  fn new() -> Self {
    Point { x: 0, y: 0 }
  }

  fn step(&mut self, c: char) -> Self {
    match c {
      '^' => self.y += 1,
      'v' => self.y -= 1,
      '>' => self.x += 1,
      '<' => self.x -= 1,
      _ => panic!("Invalid direction: {c}")
    }

    *self
  }
}