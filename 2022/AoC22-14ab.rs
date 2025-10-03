use std::fs;
use std::hash::{Hash, Hasher};
use std::collections::HashSet;
use std::cmp::{min, max};

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let points = process(&input);

  let ans1 = part1(points.to_owned());
  println!("Part 1 answer: {ans1}");

  let ans2 = part2(points);
  println!("Part 2 answer: {ans2}");
}

#[derive(Clone, Copy)]
struct Point {
  x: i32,
  y: i32,
  label: char
}

impl Point {
  fn new() -> Point {
    Point {
      x: 500,
      y: 0,
      label: 'o'
    }
  }
}

fn part1(mut points: HashSet<Point>) -> usize {
  'outer: loop {
    let mut sand = Point::new();
    loop {
      if sand.y > points.iter().map(|p| p.y).max().unwrap() {
        break 'outer;
      }

      match [0i32, -1, 1].into_iter().map(|n| Point { x: sand.x + n, y: sand.y + 1, label: 'o' }).find(|p| !points.contains(&p)) {
        Some(p) => sand = p,
        None => {
          points.insert(sand);
          break;
        }
      }
    }
  }

  points.iter().filter(|p| p.label == 'o').count()
}

fn part2(mut points: HashSet<Point>) -> usize {
  let bottom = points.iter().map(|p| p.y).max().unwrap() + 1;

  while !points.contains(&Point::new()) {
    let mut sand = Point::new();
    loop {
      if sand.y == bottom {
        points.insert(sand);
        break;
      }

      match [0i32, -1, 1].into_iter().map(|n| Point { x: sand.x + n, y: sand.y + 1, label: 'o' }).find(|p| !points.contains(&p)) {
        Some(p) => sand = p,
        None => {
          points.insert(sand);
          break;
        }
      }
    }
  }

  points.iter().filter(|p| p.label == 'o').count()
}

fn process(input: &str) -> HashSet<Point> {
  let mut points: HashSet<Point> = HashSet::new();
  let lines: Vec<Vec<(i32, i32)>> = input
    .lines()
    .map(|line| {
      line.split(" -> ").map(|l| {
        let (a, b) = l.split_once(',').unwrap();

        (a.parse().unwrap(), b.parse().unwrap())
      }).collect()
    }).collect();

  for line in lines {
    for (a, b) in line.windows(2).map(|w| (w[0], w[1])) {
      if a.0 != b.0 {
        for i in min(a.0, b.0)..=max(a.0, b.0) {
          points.insert(Point { x: i, y: a.1, label: '#' });
        }
      } else if a.1 != b.1 {
        for i in min(a.1, b.1)..=max(a.1, b.1) {
          points.insert(Point { x: a.0, y: i, label: '#' });
        }
      }
    }
  }

  points
}

impl PartialEq for Point {
  fn eq(&self, other: &Point) -> bool {
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