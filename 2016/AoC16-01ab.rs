use std::fs;
use std::collections::HashSet;
use std::ops::{Add, Rem};

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let route: Vec<(Direction, i32)> = input.split(", ").map(process).collect();

  println!("Part 1 answer: {}", part1(&route));
  println!("Part 2 answer: {}", part2(&route));
}

fn part1(route: &[(Direction, i32)]) -> i32 {
  let mut nav = Nav { pos: Point::origin(), dir: 0 };
  for (dir, dist) in route {
    nav.turn(dir);
    nav.step(*dist);
  }

  nav.pos.m_dist(&Point::origin())
}

fn part2(route: &[(Direction, i32)]) -> i32 {
  let mut record: HashSet<Point> = HashSet::new();
  record.insert(Point::origin());

  let mut nav = Nav { pos: Point::origin(), dir: 0 };
  loop {
    for (dir, dist) in route {
      nav.turn(dir);
      for _ in 0..*dist {
        if !record.insert(nav.step(1)) {
          return nav.pos.m_dist(&Point::origin());
        }
      }
    }
  }
}

fn process(s: &str) -> (Direction, i32) {
  let dir: Direction = s.chars().next().unwrap().try_into().unwrap();
  let dist: i32 = s[1..].parse().unwrap();

  (dir, dist)
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

impl Point {
  fn origin() -> Self {
    Self {
      x: 0,
      y: 0,
    }
  }

  fn m_dist(&self, other: &Self) -> i32 {
    (self.x - other.x).abs() + (self.y - other.y).abs()
  }
}

#[derive(Clone, Copy)]
struct Nav {
  pos: Point,
  dir: u32,
}

impl Nav {
  fn turn(&mut self, dir: &Direction) {
    self.dir = self.dir
      .add(match dir { Direction::Left => 3, Direction::Right => 1, _ => 0 })
      .rem(4);
  }

  fn step(&mut self, dist: i32) -> Point {
    match Direction::try_from(self.dir).unwrap() {
      Direction::Up    => self.pos.y += dist,
      Direction::Right => self.pos.x += dist,
      Direction::Down  => self.pos.y -= dist,
      Direction::Left  => self.pos.x -= dist,
    };

    self.pos
  }
}

#[derive(Clone, Copy)]
enum Direction {
  Up,
  Right,
  Down,
  Left,
}

impl TryFrom<char> for Direction {
  type Error = &'static str;

  fn try_from(value: char) -> Result<Self, Self::Error> {
    match value {
      'R' => Ok(Direction::Right),
      'L' => Ok(Direction::Left),
      _ => Err("Invalid direction"),
    }
  }
}

impl TryFrom<u32> for Direction {
  type Error = &'static str;

  fn try_from(value: u32) -> Result<Self, Self::Error> {
    match value {
      0 => Ok(Direction::Up),
      1 => Ok(Direction::Right),
      2 => Ok(Direction::Down),
      3 => Ok(Direction::Left),
      _ => Err("Invalid direction"),
    }
  }
}