use std::fs;
use std::collections::HashSet;

fn step(pos: &mut (i32, i32), c: char) {
  match c {
    '^' => pos.1 -= 1,
    '>' => pos.0 += 1,
    'v' => pos.1 += 1,
    '<' => pos.0 -= 1,
    _   => { println!("Invalid input."); }
  };
}

fn part1(input: &str) -> usize {
  let mut pos: (i32, i32) = (0, 0);
  let mut pos_record: HashSet<(i32, i32)> = HashSet::new();
  pos_record.insert(pos);
  
  for c in input.chars() {
    step(&mut pos, c);
    pos_record.insert(pos);
  }

  pos_record.len()
}

fn part2(input: &str) -> usize {
  let mut santa_pos: (i32, i32) = (0, 0);
  let mut robosanta_pos: (i32, i32) = (0, 0);

  let mut pos_record: HashSet<(i32, i32)> = HashSet::new();
  pos_record.insert(santa_pos);

  for (i, c) in input.chars().enumerate() {
    match i % 2 {
      0 => {
        step(&mut santa_pos, c);
        pos_record.insert(santa_pos);
      },
      1 => {
        step(&mut robosanta_pos, c);
        pos_record.insert(robosanta_pos);
      },
      _ => { println!("Something broke."); }
    };
  }

  pos_record.len()
}

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  println!("Part 1 answer: {}", part1(&input));
  println!("Part 2 answer: {}", part2(&input));
}
