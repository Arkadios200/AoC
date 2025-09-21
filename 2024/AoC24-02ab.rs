use std::fs;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let reports: Vec<Vec<i32>> = input.lines().map(|line| line.split(' ').map(|s| s.parse().unwrap()).collect()).collect();

  let not_safe = reports.iter().filter(|&r| !is_safe(r.to_owned()));

  let ans1 = reports.len() - not_safe.to_owned().count();
  let ans2 = ans1 + not_safe.filter(|&r| {
    (0..r.len()).any(|i| {
      let mut r = r.to_owned();
      r.remove(i);
      is_safe(r)
    })
  }).count();

  println!("Part 1 answer: {ans1}");
  println!("Part 2 answer: {ans2}");
}

fn is_safe(mut v: Vec<i32>) -> bool {
  if v[0] > v[1] { v.reverse(); }

  v.windows(2).map(|w| w[1] - w[0]).all(|n| (1..=3).contains(&n))
}