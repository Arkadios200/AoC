use std::fs;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let grid: Vec<Vec<char>> =   input.lines().map(|line| line.chars().collect()).collect();

  let ans1 = calc((3, 1), &grid);
  println!("Part 1 answer: {ans1}");

  let slopes: [(usize, usize); 5] = [
    (1, 1),
    (3, 1),
    (5, 1),
    (7, 1),
    (1, 2),
  ];
  let ans2 = slopes.iter().fold(1, |acc, &s| acc * calc(s, &grid));
  println!("Part 2 answer: {ans2}");
}

fn calc(slope: (usize, usize), grid: &[Vec<char>]) -> u32 {
  let mut pos: (usize, usize) = (0, 0);
  let mut out: u32 = 0;

  while let Some(v) = grid.get(pos.1) {
    if v[pos.0] == '#' { out += 1; }

    pos = ((pos.0 + slope.0) % v.len(), pos.1 + slope.1);
  }

  out
}