use std::fs;
use std::collections::HashSet;
use std::ops::Add;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let dirs = process(&input);

  println!("Part 1 answer: {}", calc(&dirs, 2));
  println!("Part 2 answer: {}", calc(&dirs, 10));
}

fn calc(dirs: &[(char, i32)], knot_count: usize) -> usize {
  let mut record: HashSet<Point> = HashSet::new();

  let mut knots: Vec<Point> = vec![Point::new(); knot_count];

  for &(dir, dist) in dirs {
    for _ in 1..=dist {
      knots[0].step(&dir);

      for (w, k) in knots.to_owned().windows(2).zip(&mut knots[1..]) {
        if (w[0].x - w[1].x).abs() > 1 || (w[0].y - w[1].y).abs() > 1 {
          *k = k.adjs().min_by_key(|p| p.dist(&w[0])).unwrap();
        }
      }

      record.insert(knots.iter().last().unwrap().to_owned());
    }
  }

  record.len()
}

fn process(input: &str) -> Vec<(char, i32)> {
  input.lines()
    .map(|line| line.chars().next().unwrap())
    .zip(input.lines().map(|line| line.split_once(' ').unwrap().1.parse().unwrap()))
    .collect()
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

impl Point {
  fn new() -> Self {
    Point { x: 0, y: 0 }
  }

  fn dist(&self, other: &Self) -> i32 {
    (self.x - other.x).abs() + (self.y - other.y).abs()
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

  fn step(&mut self, dir: &char) {
    match dir {
      'U' => self.y += 1,
      'D' => self.y -= 1,
      'R' => self.x += 1,
      'L' => self.x -= 1,
      _ => panic!("Invalid direction"),
    }
  }
}

impl Add<Point> for Point {
  type Output = Self;
  fn add(self, other: Self) -> Self {
    Point {
      x: self.x + other.x,
      y: self.y + other.y,
    }
  }
}
