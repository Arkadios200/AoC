use std::fs;
use std::collections::HashSet;
use std::ops::Add;
use std::cmp::{min, max};
use itertools::Itertools;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let walls: HashSet<Point> = process(&input);

  println!("Part 1 answer: {}", part1(&walls));
  println!("Part 2 answer: {}", part2(&walls));
}

fn part1(walls: &HashSet<Point>) -> usize {
  let mut record: HashSet<Point> = HashSet::new();
  let bottom = walls.iter().map(|p| p.y).max().unwrap();
  'outer: loop {
    let mut sand = Point::new_sand();
    loop {
      if sand.y > bottom { break 'outer; }

      let next_point = [0i32, -1, 1].into_iter()
        .map(|n| sand + Point { x: n, y: 1 })
        .find(|p| !record.union(walls).contains(&p));
      match next_point {
        Some(p) => sand = p,
        None => {
          record.insert(sand);
          break;
        },
      }
    }
  }

  record.len()
}

fn part2(walls: &HashSet<Point>) -> usize {
  let bottom = walls.iter().map(|p| p.y).max().unwrap() + 1;

  let mut record: HashSet<Point> = HashSet::new();
  while !record.contains(&Point::new_sand()) {
    let mut sand = Point::new_sand();
    loop {
      if sand.y == bottom {
        record.insert(sand);
        break;
      }

        let next_point = [0i32, -1, 1].into_iter()
          .map(|n| sand + Point { x: n, y: 1 })
          .find(|p| !record.union(walls).contains(&p));
        match next_point {
        Some(p) => sand = p,
        None => {
          record.insert(sand);
          break;
        },
      }
    }
  }

  record.len()
}

fn process(input: &str) -> HashSet<Point> {
  let lines: Vec<Vec<Point>> = input.lines()
    .map(|line| {
      line.split(" -> ").map(|s| {
        let (a, b) = s.split_once(',').unwrap();

        Point {
          x: a.parse().unwrap(),
          y: b.parse().unwrap(),
        }
      }).collect()
    }).collect();

  let mut walls: HashSet<Point> = HashSet::new();
  for line in lines {
    for (a, b) in line.into_iter().tuple_windows() {
      if a.x != b.x {
        for i in min(a.x, b.x)..=max(a.x, b.x) {
          walls.insert(Point { x: i, y: a.y });
        }
      } else if a.y != b.y {
        for i in min(a.y, b.y)..=max(a.y, b.y) {
          walls.insert(Point { x: a.x, y: i });
        }
      } else { panic!(); }
    }
  }

  walls
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

impl Point {
  fn new_sand() -> Self {
    Self {
      x: 500,
      y: 0,
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