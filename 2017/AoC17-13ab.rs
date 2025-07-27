use std::fs;
use std::collections::HashMap;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let firewall: HashMap<u32, u32> = process(&input);

  let ans1: u32 = firewall.iter().fold(0, |acc, (depth, range)| acc + if depth % (2 * range - 2) == 0 { depth * range } else { 0 });
  println!("{ans1}");

  let ans2: u32 = {
    let mut delay = 0;
    loop {
      delay += 1;
      if firewall.iter().all(|(depth, range)| (depth + delay) % (2 * range - 2) != 0) {
        break delay;
      }
    }
  };
  println!("{ans2}");
}

fn process(input: &str) -> HashMap<u32, u32> {
  let mut firewall: HashMap<u32, u32> = HashMap::new();
  for line in input.lines() {
    let (a, b) = line.split_once(": ").unwrap();
    firewall.insert(a.parse().unwrap(), b.parse().unwrap());
  }

  firewall
}