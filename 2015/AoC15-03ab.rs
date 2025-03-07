use std::fs;
use std::collections::HashSet;

fn step(pos: &mut (i32, i32), c: char) -> (i32, i32) {
  match c {
    '^' => pos.1 -= 1,
    '>' => pos.0 += 1,
    'v' => pos.1 += 1,
    '<' => pos.0 -= 1,
    _   => { println!("Invalid input."); }
  };

  *pos
}

fn part1(input: &str) -> usize {
  let mut pos: (i32, i32) = (0, 0);
  let mut pos_record: HashSet<(i32, i32)> = HashSet::new();
  pos_record.insert(pos);
  
  for c in input.chars() {
    pos_record.insert(step(&mut pos, c));
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
        pos_record.insert(step(&mut santa_pos, c));
      },
      1 => {
        pos_record.insert(step(&mut robosanta_pos, c));
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
