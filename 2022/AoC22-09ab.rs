use std::fs;
use std::collections::HashSet;
use std::ops::Add;
use itertools::Itertools;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let dirs: Vec<(Direction, i32)> = input.lines().map(process).collect();

  println!("{}", calc(&dirs,  2));
  println!("{}", calc(&dirs, 10));
}

fn calc(dirs: &[(Direction, i32)], knots: usize) -> usize {
  let mut record: HashSet<Point> = HashSet::new();
  let mut rope: Vec<Point> = vec![Point::origin(); knots];

  for &(dir, dist) in dirs {
    for _ in 0..dist {
      rope[0].step(&dir);

      for (i, (a, b)) in (1..).zip(rope.to_owned().iter().tuple_windows()) {
        if a.diag_dist(b) > 1 {
          rope[i] = b.adjs().min_by_key(|p| p.m_dist(a)).unwrap();
        }
      }

      record.insert(rope.iter().last().unwrap().to_owned());
    }
  }

  record.len()
}

fn process(line: &str) -> (Direction, i32) {
  let (a, b) = line.split_once(' ').unwrap();

  (match a.chars().next().unwrap() {
    'U' => Direction::Up,
    'D' => Direction::Down,
    'R' => Direction::Right,
    'L' => Direction::Left,
    _ => panic!(),
  }, b.parse().unwrap())
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

  fn diag_dist(&self, other: &Self) -> i32 {
    (self.x - other.x).abs().max((self.y - other.y).abs())
  }

  fn adjs(&self) -> impl Iterator<Item = Self> {
    let p = *self;

    [
      (0, 1),
      (1, 1),
      (1, 0),
      (1, -1),
      (0, -1),
      (-1, -1),
      (-1, 0),
      (-1, 1),
    ].into_iter().map(move |(x, y)| p + Point { x, y })
  }

  fn step(&mut self, dir: &Direction) {
    match dir {
      Direction::Up    => self.y += 1,
      Direction::Down  => self.y -= 1,
      Direction::Right => self.x += 1,
      Direction::Left  => self.x -= 1,
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

#[derive(Clone, Copy)]
enum Direction {
  Up,
  Down,
  Right,
  Left,
}