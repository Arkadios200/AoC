use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let (points, lines) = process(&input);

  let (ans1, ans2) = calc(&points, &lines);
  println!("Part 1 answer: {ans1}");
  println!("Part 2 answer:");
  ans2.iter()
    .map(|line| line.iter().collect::<String>())
    .for_each(|line| println!("{line}"));
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: u32,
  y: u32
}

fn calc(points: &[Point], lines: &[(char, u32)]) -> (usize, Vec<Vec<char>>) {
  let mut points = points.to_owned();
  let mut lines  = lines.iter();

  points = round(&points, *lines.next().unwrap());
  let ans1 = points.len();

  for &line in lines {
    points = round(&points, line);
  }

  (ans1, layout(&points))
}

fn round(points: &[Point], line: (char, u32)) -> Vec<Point> {
  let mut points = points.to_owned();
  let (dir, coord) = line;

  match dir {
    'x' => {
      for p in points.iter_mut().filter(|p| p.x > coord) {
        p.x = 2 * coord - p.x;
      }
    },
    'y' => {
      for p in points.iter_mut().filter(|p| p.y > coord) {
        p.y = 2 * coord - p.y;
      }
    },
    _ => panic!("Invalid input: {dir}")
  }

  HashSet::<Point>::from_iter(points).into_iter().collect()
}

fn layout(points: &[Point]) -> Vec<Vec<char>> {
  let width: usize  = points.iter().map(|p| p.x).max().unwrap() as usize + 1;
  let height: usize = points.iter().map(|p| p.y).max().unwrap() as usize + 1;

  let mut layout = vec![vec![' '; width]; height];
  for p in points {
    layout[p.y as usize][p.x as usize] = '█';
  }

  layout
}

fn process(input: &str) -> (Vec<Point>, Vec<(char, u32)>) {
  let mut blocks = input.split("\n\n");

  let points: Vec<Point> = blocks.next().unwrap()
    .lines()
    .map(|line| {
      let (a, b) = line.split_once(',').unwrap();

      Point {
        x: a.parse().unwrap(),
        y: b.parse().unwrap()
      }
    }).collect();

  let lines: Vec<(char, u32)> = blocks.next().unwrap()
    .lines()
    .map(|line| {
      let mut s = line.split(' ')
        .last().unwrap()
        .chars();

      let dir = s.next().unwrap();
      let coord: u32 = s.skip(1)
        .collect::<String>()
        .parse().unwrap();

      (dir, coord)
    }).collect();

  (points, lines)
}