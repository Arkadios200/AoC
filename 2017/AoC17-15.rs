fn main() {
  let a = 65;
  let b = 8921;

  println!("Part 1 answer: {}", part1(a, b));
  println!("Part 2 answer: {}", part2(a, b));
}

fn part1(mut a: u64, mut b: u64) -> u32 {
  let n = (1 << 16) - 1;

  let mut total: u32 = 0;
  for _ in 1..=40000000 {
    a = (a * 16807) % 2147483647;
    b = (b * 48271) % 2147483647;

    if (a & n) == (b & n) { total += 1; }
  }

  total
}

fn part2(mut a: u64, mut b: u64) -> u32 {
  let n = (1 << 16) - 1;

  let mut total: u32 = 0;
  for _ in 1..=5000000 {
    loop {
      a = (a * 16807) % 2147483647;
      if a % 4 == 0 { break; }
    }
    loop {
      b = (b * 48271) % 2147483647;
      if b % 8 == 0 { break; }
    }

    if (a & n) == (b & n) { total += 1; }
  }

  total
}