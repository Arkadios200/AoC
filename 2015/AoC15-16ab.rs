use std::fs;
use std::collections::HashMap;

struct Aunt {
  num: u32,
  data: Vec<(String, u32)>
}

impl From<&str> for Aunt {
  fn from(line: &str) -> Aunt {
    let temp = line.split_whitespace().collect::<String>();
    let (a, b) = temp.split_once(':').unwrap();

    let num: u32 = a.chars()
    .filter(|c| c.is_digit(10))
    .collect::<String>()
    .parse().unwrap();

    let data: Vec<(String, u32)> = b.split(',')
    .map(|s| {
      let (key, value) = s.split_once(':').unwrap();
      (String::from(key), value.parse().unwrap())
    }).collect();

    Aunt { num, data }
  }
}

fn main() {
  let target_data = HashMap::from([
    ("children",    (3, (|x| x == 3) as fn(u32) -> bool)),
    ("cats",        (7, (|x| x  > 7))),
    ("samoyeds",    (2, (|x| x == 2))),
    ("pomeranians", (3, (|x| x  < 3))),
    ("akitas",      (0, (|x| x == 0))),
    ("vizslas",     (0, (|x| x == 0))),
    ("goldfish",    (5, (|x| x  < 5))),
    ("trees",       (3, (|x| x  > 3))),
    ("cars",        (2, (|x| x == 2))),
    ("perfumes",    (1, (|x| x == 1)))
  ]);


  let input = fs::read_to_string("input.txt").unwrap();
  let aunts: Vec<Aunt> = input.split('\n').map(|line| Aunt::from(line)).collect();

  let ans1 = aunts.iter().find(|aunt|
    aunt.data.iter().all(|(key, value)| target_data[key.as_str()].0 == *value)
  ).unwrap().num;
  println!("Part 1 answer: {ans1}");

  let ans2 = aunts.iter().find(|aunt|
    aunt.data.iter().all(|(key, value)| target_data[key.as_str()].1(*value))
  ).unwrap().num;
  println!("Part 2 answer: {ans2}");
}