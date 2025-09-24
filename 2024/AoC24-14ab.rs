use std::fs;
use std::hash::{Hash, Hasher};
use std::collections::HashSet;
use std::ops::{Add, AddAssign, Mul};

/*
const WIDTH: i32 = 101;
const HEIGHT: i32 = 103;
*/

const BOUNDS: Point = Point {
  x: 101,
  y: 103,
};

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let robots: Vec<Robot> = process(&input);

  println!("Part 1 answer: {}", part1(robots.to_owned()));
  println!("Part 2 answer: {}", part2(robots.to_owned()));
}

fn part1(mut robots: Vec<Robot>) -> usize {
  for r in &mut robots { r.step(100); }

  let mid_x = BOUNDS.x / 2;
  let mid_y = BOUNDS.y / 2;
  [
    robots.iter().filter(|&r| r.pos.x < mid_x && r.pos.y < mid_y).count(),
    robots.iter().filter(|&r| r.pos.x < mid_x && r.pos.y > mid_y).count(),
    robots.iter().filter(|&r| r.pos.x > mid_x && r.pos.y < mid_y).count(),
    robots.iter().filter(|&r| r.pos.x > mid_x && r.pos.y > mid_y).count(),
  ].into_iter().product()
}

fn part2(mut robots: Vec<Robot>) -> u32 {
  let mut n = 0;
  while HashSet::<Robot>::from_iter(robots.to_owned()).len() != robots.len() {
    n += 1;
    for r in &mut robots { r.step(1); }
  }

  n
}

fn process(input: &str) -> Vec<Robot> {
  input.lines().map(|line| {
    let mut t = line.split(|c: char| !"-0123456789".contains(c)).filter_map(|s| if !s.is_empty() { Some(s.parse::<i32>().unwrap()) } else { None });
    assert_eq!(t.to_owned().count(), 4);

    Robot {
      pos: Point {
        x: t.next().unwrap(),
        y: t.next().unwrap(),
      },
      vel: Point {
        x: t.next().unwrap(),
        y: t.next().unwrap(),
      },
    }
  }).collect()
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

impl Point {
  fn rem_euclid(self, other: Self) -> Self {
    Self {
      x: self.x.rem_euclid(other.x),
      y: self.y.rem_euclid(other.y),
    }
  }
}

impl Add for Point {
  type Output = Self;
  fn add(self, other: Self) -> Self {
    Self {
      x: self.x + other.x,
      y: self.y + other.y,
    }
  }
}

impl AddAssign for Point {
  fn add_assign(&mut self, other: Self) {
    *self = *self + other;
  }
}

impl Mul<i32> for Point {
  type Output = Self;
  fn mul(self, n: i32) -> Self {
    Self {
      x: self.x * n,
      y: self.y * n,
    }
  }
}

#[derive(Debug, Clone, Copy)]
struct Robot {
  pos: Point,
  vel: Point,
}

impl Robot {
  fn step(&mut self, n: i32) {
    self.pos += self.vel * n;
    self.pos = self.pos.rem_euclid(BOUNDS);
  }
}

impl PartialEq for Robot {
  fn eq(&self, other: &Self) -> bool {
    self.pos == other.pos
  }
}

impl Eq for Robot {}

impl Hash for Robot {
  fn hash<H: Hasher>(&self, state: &mut H) {
    self.pos.hash(state);
  }
}