use std::fs;
use std::hash::{Hash, Hasher};
use std::collections::HashSet;

const WIDTH: i32 = 101;
const HEIGHT: i32 = 103;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let robots: Vec<Robot> = input.lines().map(|line| {
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
  }).collect();

  println!("Part 1 answer: {}", part1(robots.to_owned()));
  println!("Part 2 answer: {}", part2(robots.to_owned()));
}

fn part1(mut robots: Vec<Robot>) -> usize {
  for _ in 1..=100 {
    for r in &mut robots { r.step(); }
  }

  [
    robots.iter().filter(|&r| r.pos.x < WIDTH / 2 && r.pos.y < HEIGHT / 2).count(),
    robots.iter().filter(|&r| r.pos.x < WIDTH / 2 && r.pos.y > HEIGHT / 2).count(),
    robots.iter().filter(|&r| r.pos.x > WIDTH / 2 && r.pos.y < HEIGHT / 2).count(),
    robots.iter().filter(|&r| r.pos.x > WIDTH / 2 && r.pos.y > HEIGHT / 2).count(),
  ].into_iter().product()
}

fn part2(mut robots: Vec<Robot>) -> u32 {
  let mut n = 0;
  while HashSet::<Robot>::from_iter(robots.to_owned()).len() != robots.len() {
    n += 1;
    for r in &mut robots { r.step(); }
  }

  n
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

#[derive(Clone, Copy)]
struct Robot {
  pos: Point,
  vel: Point,
}

impl Robot {
  fn step(&mut self) {
    self.pos.x = (self.pos.x + self.vel.x + WIDTH) % WIDTH;
    self.pos.y = (self.pos.y + self.vel.y + HEIGHT) % HEIGHT;
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