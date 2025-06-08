use std::fs;
use itertools::Itertools;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();
  let program: Vec<i32> = input.split(',')
    .map(|i| i.trim().parse().unwrap())
    .collect();

  let ans1 = (0..5).permutations(5).map(|p| {
    p.into_iter().fold(0, |acc, v| run(&program, [v, acc].into_iter()))
  }).max().unwrap();
  println!("Part 1 answer: {ans1}");
}

fn run(program: &Vec<i32>, mut input: impl Iterator<Item = i32>) -> i32 {
  let mut program = program.to_owned();

  let mut output: i32 = 0;
  
  let mut i: usize = 0;
  loop {
    if !(0..program.len()).contains(&i) { panic!("Out of range") }

    let mut temp = program[i];

    let opcode = temp % 100;
    if opcode == 99 { break; }
    temp /= 100;

    let op_count = match opcode {
      1 | 2 | 7 | 8 => 3,
      3 | 4 => 1,
      5 | 6 => 2,
      _ => panic!("Invalid opcode")
    };

    let mut args: Vec<usize> = vec![];
    for j in 0..op_count {
      args.push(match temp % 10 {
        0 => program[i+j+1] as usize,
        1 => i+j+1,
        _ => panic!("Invalid opcode")
      });

      temp /= 10;
    }

    match opcode {
      1 => program[args[2]] = program[args[0]] + program[args[1]],
      2 => program[args[2]] = program[args[0]] * program[args[1]],
      3 => program[args[0]] = input.next().unwrap(),
      4 => output = program[args[0]],
      5 => {
        if program[args[0]] != 0 {
          i = program[args[1]] as usize;
          continue;
        }
      },
      6 => {
        if program[args[0]] == 0 {
          i = program[args[1]] as usize;
          continue;
        }
      },
      7 => program[args[2]] = if program[args[0]]  < program[args[1]] { 1 } else { 0 },
      8 => program[args[2]] = if program[args[0]] == program[args[1]] { 1 } else { 0 },
      _ => panic!("Invalid opcode")
    }

    i += op_count + 1;
  }

  output
}