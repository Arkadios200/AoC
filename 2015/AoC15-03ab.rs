use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();
  let dirs: Vec<Direction> = input
    .chars()
    .map(|c| Direction::try_from(c).unwrap())
    .collect();

  println!("Part 1 answer: {}", part1(&dirs));
  println!("Part 2 answer: {}", calc(&dirs, 2));
}

fn part1(dirs: &[Direction]) -> usize {
  let mut pos = Point::origin();
  let mut record: HashSet<Point> = HashSet::new();
  record.insert(pos);

  for dir in dirs {
    record.insert(pos.step(dir));
  }

  record.len()
}

fn calc(dirs: &[Direction], n: usize) -> usize {
  let mut pos: Vec<Point> = vec![Point::origin(); n];
  let mut record: HashSet<Point> = HashSet::new();
  record.insert(pos[0]);

  for (i, dir) in dirs.iter().enumerate() {
    record.insert(pos[i % n].step(dir));
  }

  record.len()
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

  fn step(&mut self, dir: &Direction) -> Self {
    match dir {
      Direction::Up    => self.y += 1,
      Direction::Down  => self.y -= 1,
      Direction::Right => self.x += 1,
      Direction::Left  => self.x -= 1,
    };

    *self
  }
}

#[derive(Clone, Copy)]
enum Direction {
  Up,
  Down,
  Right,
  Left,
}

impl TryFrom<char> for Direction {
  type Error = &'static str;

  fn try_from(value: char) -> Result<Self, Self::Error> {
    match value {
      '^' => Ok(Direction::Up),
      'v' => Ok(Direction::Down),
      '>' => Ok(Direction::Right),
      '<' => Ok(Direction::Left),
      _ => Err("Invalid direction"),
    }
  }
}