use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let mut dirs = input.chars().map(|c| match c { '<' => -1i32, '>' => 1, _ => panic!() }).cycle();

  let mut shapes = [
    vec![
      (0, 0),
      (1, 0),
      (2, 0),
      (3, 0),
    ],
    vec![
      (1, 2),
      (0, 1),
      (1, 1),
      (2, 1),
      (1, 0),
    ],
    vec![
      (2, 2),
      (2, 1),
      (0, 0),
      (1, 0),
      (2, 0),
    ],
    vec![
      (0, 3),
      (0, 2),
      (0, 1),
      (0, 0),
    ],
    vec![
      (0, 1),
      (1, 1),
      (0, 0),
      (1, 0),
    ],
  ].into_iter().cycle();

  let mut record: HashSet<Point> = HashSet::new();

  for _ in 1..=2022 {
    let m = record.iter().map(|&p| p.y).max().unwrap_or(0);
    let mut shape: Vec<Point> = shapes.next().unwrap().into_iter().map(|(x, y)| Point { x: x + 2, y: y + m + 4 }).collect();

    loop {
      let d = dirs.next().unwrap();
      if shape.iter().map(|&p| Point { x: p.x + d, ..p }).all(|p| !record.contains(&p) && (0..7).contains(&p.x)) {
        for p in &mut shape { p.x += d; }
      }

      if shape.iter().map(|&p| Point { y: p.y - 1, ..p }).any(|p| record.contains(&p) || p.y == 0) {
        break;
      }

      for p in &mut shape { p.y -= 1; }
    }

    for p in shape { record.insert(p); }
  }

  println!("{}", record.iter().map(|&p| p.y).max().unwrap());
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}