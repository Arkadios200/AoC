use std::fs;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let lines: Vec<String> = input.split(',').map(String::from).collect();

  let ans1: usize = lines.iter().map(|s| hash_alg(s)).sum();
  println!("{ans1}");

  let ans2: u32 = part2(&lines);
  println!("{ans2}");
}

fn hash_alg(s: &str) -> usize {
  s.as_bytes().into_iter().fold(0usize, |acc, &b| ((acc + b as usize) * 17) % 256)
}

fn part2(lines: &[String]) -> u32 {
  let mut cases: [Vec<Lens>; 256] = std::array::from_fn(|_| Vec::new());

  for line in lines {
    if let Some((a, b)) = line.split_once('=') {
      let label: String     = a.to_string();
      let focal_length: u32 = b.parse().unwrap();

      let case: usize = hash_alg(&label);
      match cases[case].iter().position(|lens| lens.label == label) {
        Some(i) => cases[case][i].focal_length = focal_length,
        None => cases[case].push(Lens { label, focal_length }),
      }
    } else {
      let label = &line[..line.len()-1];
      let case: usize = hash_alg(label);
      cases[case].retain(|lens| lens.label != label);
    }
  }

  cases.iter().enumerate().map(|(i, case)| {
    case.iter().enumerate().fold(0u32, |acc, (j, lens)| {
      acc
      + (i as u32 + 1)
      * (j as u32 + 1)
      * lens.focal_length
    })
  }).sum()
}

struct Lens {
  label: String,
  focal_length: u32,
}