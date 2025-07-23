use std::fs;
use std::collections::HashMap;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let firewall: HashMap<u32, u32> = process(&input);

  let (ans1, ans2) = solve(&firewall);
  println!("{ans1}");
  println!("{ans2}");
}

fn solve(firewall: &HashMap<u32, u32>) -> (u32, u32) {
  let mut delay = 0;
  let ans1 = traverse(firewall, delay);
  let ans2 = {
    loop {
      delay += 1;
      if delay % (2 * firewall.get(&0).unwrap() - 2) == 0 { continue; }

      if traverse(firewall, delay) == 0 { break delay; }
    }
  };

  (ans1, ans2)
}

fn traverse(firewall: &HashMap<u32, u32>, delay: u32) -> u32 {
  firewall.iter().fold(0u32, |acc, (depth, range)| acc + if (depth + delay) % (2 * range - 2) == 0 { depth * range } else { 0 })
}

fn process(input: &str) -> HashMap<u32, u32> {
  let mut firewall: HashMap<u32, u32> = HashMap::new();
  for line in input.lines() {
    let (a, b) = line.split_once(": ").unwrap();
    firewall.insert(a.parse().unwrap(), b.parse().unwrap());
  }

  firewall
}