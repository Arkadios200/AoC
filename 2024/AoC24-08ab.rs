use std::fs;
use std::collections::{HashSet, HashMap};
use std::ops::{Add, Sub, AddAssign, SubAssign};

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let antennae = process(&input);
  let bounds = {
    let width = input.lines().next().unwrap().chars().count() as i32;
    let height = input.lines().count() as i32;

    Point {
      x: width,
      y: height,
    }
  };
  
  println!("Part 1 answer: {}", part1(&antennae, bounds));
  println!("Part 2 answer: {}", part2(&antennae, bounds));
}

fn part1(antennae: &HashMap<char, Vec<Point>>, bounds: Point) -> usize {
  let mut antinodes: HashSet<Point> = HashSet::new();

  for (_, val) in antennae {
    for i in 0..(val.len()-1) {
      for j in (i+1)..val.len() {
        let (a, b) = (val[i], val[j]);

        let diff = a - b;
        antinodes.insert(a + diff);
        antinodes.insert(b - diff);
      }
    }
  }

  antinodes.into_iter().filter(|p| p.is_within(&bounds)).count()
}

fn part2(antennae: &HashMap<char, Vec<Point>>, bounds: Point) -> usize {
  let mut antinodes: HashSet<Point> = HashSet::new();

  for (_, val) in antennae {
    for i in 0..(val.len()-1) {
      for j in (i+1)..val.len() {
        let (mut a, mut b) = (val[i], val[j]);

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
  }

  antinodes.len()
}

fn process(input: &str) -> HashMap<char, Vec<Point>> {
  let mut antennae: HashMap<char, Vec<Point>> = HashMap::new();
  for (y, line) in input.lines().enumerate() {
    for (x, c) in line.chars().enumerate() {
      if c != '.' {
        antennae.entry(c).or_insert(vec![]).push(Point { x: x as i32, y: y as i32 });
      }
    }
  }

  antennae
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