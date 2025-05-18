use std::fs;
use std::collections::HashSet;
use std::hash::{Hash, Hasher};

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();
  let lines: Vec<(char, i32)> = input.split(", ").map(|s| {
    let mut c = s.chars();
    (c.next().unwrap(), c.collect::<String>().parse().unwrap())
  }).collect();

  let ans1 = part1(&lines);
  println!("Part 1 answer: {ans1}");

  let ans2 = part2(&lines);
  println!("Part 2 answer: {ans2}");
}

fn part1(lines: &Vec<(char, i32)>) -> i32 {
  let mut pos = Point::new();
  for (dir, dist) in lines {
    pos.turn(dir);
    pos.step(dist);
  }

  pos.m_dist()
}

fn part2(lines: &Vec<(char, i32)>) -> i32 {
  let mut pos = Point::new();
  let mut record: HashSet<Point> = HashSet::from([pos]);

  loop {
    for (dir, dist) in lines {
      pos.turn(dir);
      for _ in 0..*dist {
        if !record.insert(pos.step(&1)) {
          return pos.m_dist();
        }
      }
    }
  }
}

#[derive(Clone, Copy)]
struct Point {
  x: i32,
  y: i32,
  dir: i32
}

impl Point {
  fn new() -> Self {
    Point { x: 0, y: 0, dir: 0 }
  }

  fn turn(&mut self, c: &char) {
    self.dir = match c {
      'L' => (self.dir + 3) % 4,
      'R' => (self.dir + 1) % 4,
      _ => self.dir
    }
  }

  fn step(&mut self, dist: &i32) -> Self {
    match self.dir {
      0 => self.y += dist,
      1 => self.x += dist,
      2 => self.y -= dist,
      3 => self.x -= dist,
      _ => {}
    }

    *self
  }

  fn m_dist(&self) -> i32 {
    self.x.abs() + self.y.abs()
  }
}

impl PartialEq for Point {
  fn eq(&self, other: &Self) -> bool {
    self.x == other.x && self.y == other.y
  }
}

impl Eq for Point {}

impl Hash for Point {
  fn hash<H: Hasher>(&self, state: &mut H) {
    self.x.hash(state);
    self.y.hash(state);
  }
}