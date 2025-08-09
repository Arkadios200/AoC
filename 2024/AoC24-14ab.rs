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
      px: t.next().unwrap(),
      py: t.next().unwrap(),
      vx: t.next().unwrap(),
      vy: t.next().unwrap(),
    }
  }).collect();

  println!("Part 1 answer: {}", part1(&robots));
  println!("Part 2 answer: {}", part2(&robots));
}

fn part1(robots: &[Robot]) -> usize {
  let mut robots = robots.to_owned();

  for _ in 1..=100 {
    for r in &mut robots { r.step(); }
  }

  let quadrants: [usize; 4] = [
    robots.iter().filter(|&r| r.px < WIDTH / 2 && r.py < HEIGHT / 2).count(),
    robots.iter().filter(|&r| r.px < WIDTH / 2 && r.py > HEIGHT / 2).count(),
    robots.iter().filter(|&r| r.px > WIDTH / 2 && r.py < HEIGHT / 2).count(),
    robots.iter().filter(|&r| r.px > WIDTH / 2 && r.py > HEIGHT / 2).count(),
  ];

  quadrants.into_iter().product()
}

fn part2(robots: &[Robot]) -> u32 {
  let mut robots = robots.to_owned();

  let mut n = 0;
  while HashSet::<Robot>::from_iter(robots.to_owned()).len() != robots.len() {
    n += 1;
    for r in &mut robots { r.step(); }
  }

  n
}

#[derive(Clone, Copy)]
struct Robot {
  px: i32,
  py: i32,
  vx: i32,
  vy: i32,
}

impl Robot {
  fn step(&mut self) {
    self.px = (self.px + self.vx + WIDTH) % WIDTH;
    self.py = (self.py + self.vy + HEIGHT) % HEIGHT;
  }
}

impl PartialEq for Robot {
  fn eq(&self, other: &Self) -> bool {
    self.px == other.px && self.py == other.py
  }
}

impl Eq for Robot {}

impl Hash for Robot {
  fn hash<H: Hasher>(&self, state: &mut H) {
    self.px.hash(state);
    self.py.hash(state);
  }
}

/*
fn layout(robots: &[Robot]) -> String {
  let mut grid = [['.'; WIDTH as usize]; HEIGHT as usize];
  for r in robots { grid[r.py as usize][r.px as usize] = '#' }

  grid.into_iter().fold(String::new(), |acc, row| format!("{acc}{}\n", String::from_iter(row)))
}
*/
