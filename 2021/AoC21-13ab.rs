use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let (points, dirs) = process(&input);

  let (ans1, ans2) = calc(points, dirs.into_iter());

  println!("Part 1 answer: {ans1}");
  println!("Part 2 answer:\n{ans2}");
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

fn calc<I>(mut points: Vec<Point>, mut lines: I) -> (usize, String)
  where I: Iterator<Item = (char, i32)>
{
  points = round(points, lines.next().unwrap()); 
  let ans1 = points.len();

  for line in lines {
    points = round(points, line);
  }

  (ans1, layout(&points))
}

fn round(mut points: Vec<Point>, (dir, coord): (char, i32)) -> Vec<Point> {
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
    _ => panic!("Invalid dir: {dir}")
  }

  Vec::from_iter(HashSet::<Point>::from_iter(points.into_iter()).into_iter())
}

fn layout(points: &[Point]) -> String {
  let width: usize  = points.iter().map(|p| p.x).max().unwrap() as usize + 1;
  let height: usize = points.iter().map(|p| p.y).max().unwrap() as usize + 1;

  let mut layout = vec![vec![' '; width]; height];
  for p in points {
    layout[p.y as usize][p.x as usize] = '█';
  }

  layout.into_iter()
    .map(|v| v.into_iter().collect::<String>())
    .collect::<Vec<String>>()
    .join("\n")
}

fn process(input: &str) -> (Vec<Point>, Vec<(char, i32)>) {
  let mut blocks = input.split("\n\n");

  let points: Vec<Point> = blocks.next().unwrap()
    .lines()
    .map(|line| {
      let (a, b) = line.split_once(',').unwrap();
  
      Point {
        x: a.parse().unwrap(),
        y: b.parse().unwrap(),
      }
    }).collect();

  let dirs: Vec<(char, i32)> = blocks.next().unwrap()
    .lines()
    .map(|line| {
      let (a, b) = line.split_once('=').unwrap();

      (a.chars().last().unwrap(), b.parse().unwrap())
    }).collect();

  (points, dirs)
}