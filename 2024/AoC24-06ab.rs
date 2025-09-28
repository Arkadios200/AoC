use std::fs;
use std::collections::HashSet;
use std::ops::Add;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let (guard, obstacles, bounds) = process(&input);

  let path = part1(guard, &obstacles, bounds);
  println!("Part 1 answer: {}", path.len());
  println!("Part 2 answer: {}", part2(guard, &obstacles, bounds, &path));
}

fn part1(mut guard: Guard, obstacles: &HashSet<Point>, bounds: Point) -> HashSet<Point> {
  let mut path: HashSet<Point> = HashSet::new();

  while guard.step(obstacles).is_within(&bounds) {
    path.insert(guard.pos);
  }

  path
}

fn part2(guard: Guard, obstacles: &HashSet<Point>, bounds: Point, path: &HashSet<Point>) -> usize {
  let mut n = 0;
  for &p in path {
    let mut obstacles = obstacles.to_owned();
    obstacles.insert(p);

    let mut guard = guard;
    let mut vels: HashSet<Guard> = HashSet::new();

    while guard.step(&obstacles).is_within(&bounds) {
      if !vels.insert(guard) {
        n += 1;
        break;
      }
    }
  }

  n
}

fn process(input: &str) -> (Guard, HashSet<Point>, Point) {
  let mut guard: Option<Guard> = None;
  let mut obstacles: HashSet<Point> = HashSet::new();
  for (i, line) in input.lines().enumerate() {
    for (j, c) in line.chars().enumerate() {
      match c {
        '^' => match guard {
            Some(_) => panic!("Invalid input: More than one guard"),
            None => guard = Some(Guard { pos: Point { x: j as i32, y: i as i32 }, dir: 0 }),
        },
        '#' => { obstacles.insert(Point { x: j as i32, y: i as i32 }); },
        _ => {}
      }
    }
  }

  assert_ne!(guard, None);

  let bounds: Point = {
    let width = input.lines().next().unwrap()
      .chars().count() as i32;
    let height = input.lines().count() as i32;

    Point {
      x: width,
      y: height,
    }
  };

  (guard.unwrap(), obstacles, bounds)
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

impl Point {
  fn is_within(&self, bounds: &Self) -> bool {
    (0..bounds.x).contains(&self.x) && (0..bounds.y).contains(&self.y)
  }
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Guard {
  pos: Point,
  dir: usize
}

impl Guard {
  fn next_pos(&self) -> Point {
    self.pos + [
      Point { x: 0, y: -1 },
      Point { x: 1, y: 0 },
      Point { x: 0, y: 1 },
      Point { x: -1, y: 0 },
    ][self.dir]
  }

  fn turn(&mut self) {
    self.dir = (self.dir + 1) % 4;
  }
  
  fn step(&mut self, obstacles: &HashSet<Point>) -> Point {
    while obstacles.contains(&self.next_pos()) {
      self.turn();
    }

    self.pos = self.next_pos();
    self.pos
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