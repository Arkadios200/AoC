use std::fs;
use std::collections::{HashSet, HashMap};
use std::ops::{Add, AddAssign, Sub, SubAssign};
use itertools::Itertools;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let (antennae, bounds) = process(&input);

  println!("Part 1 answer: {}", part1(antennae.values(), bounds));
  println!("Part 2 answer: {}", part2(antennae.values(), bounds));
}

fn part1<'a, I>(antennae: I, bounds: Point) -> usize
where I: Iterator<Item = &'a Vec<Point>>
{
  let mut antinodes: HashSet<Point> = HashSet::new();

  for v in antennae {
    for (&a, &b) in v.iter().tuple_combinations() {
      let diff = a - b;
      antinodes.insert(a + diff);
      antinodes.insert(b - diff);
    }
  }

  antinodes.into_iter()
    .filter(|p| p.is_within(&bounds))
    .count()
}

fn part2<'a, I>(antennae: I, bounds: Point) -> usize
where I: Iterator<Item = &'a Vec<Point>>
{
  let mut antinodes: HashSet<Point> = HashSet::new();

  for v in antennae {
    for (&(mut a), &(mut b)) in v.iter().tuple_combinations() {
      let diff = a - b;
      while a.is_within(&bounds) {
        antinodes.insert(a);
        a += diff;
      }
      while b.is_within(&bounds) {
        antinodes.insert(b);
        b -= diff;
      }
    }
  }

  antinodes.len()
}

fn process(input: &str) -> (HashMap<char, Vec<Point>>, Point) {
  let mut antennae: HashMap<char, Vec<Point>> = HashMap::new();
  for (y, line) in input.lines().enumerate() {
    for (x, c) in line.chars().enumerate() {
      if c != '.' {
        antennae.entry(c).or_insert(vec![]).push(Point { x: x as i32, y: y as i32 });
      }
    }
  }

  let bounds: Point = {
    let width = input.lines().next().unwrap().chars().count() as i32;
    let height = input.lines().count() as i32;

    Point {
      x: width,
      y: height,
    }
  };

  (antennae, bounds)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

impl Point {
  fn is_within(&self, bounds: &Self) -> bool {
    (0..bounds.x).contains(&self.x) && (0..bounds.y).contains(&self.y)
  }
}

impl Add for Point {
  type Output = Self;
  fn add(self, other: Self) -> Self {
    Point {
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

impl Sub for Point {
  type Output = Self;
  fn sub(self, other: Self) -> Self {
    Point {
      x: self.x - other.x,
      y: self.y - other.y,
    }
  }
}

impl SubAssign for Point {
  fn sub_assign(&mut self, other: Self) {
    *self = *self - other;
  }
}