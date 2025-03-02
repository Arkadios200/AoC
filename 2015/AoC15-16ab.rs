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
  let conds: Vec<Box<dyn Fn(u32) -> bool>> = vec![
    Box::new(|x| x == 3),
    Box::new(|x| x  > 7),
    Box::new(|x| x == 2),
    Box::new(|x| x  < 3),
    Box::new(|x| x == 0),
    Box::new(|x| x == 0),
    Box::new(|x| x  < 5),
    Box::new(|x| x  > 3),
    Box::new(|x| x == 2),
    Box::new(|x| x == 1)
  ];
  
  let target_data = HashMap::from([
    ("children",    (3, &conds[0])),
    ("cats",        (7, &conds[1])),
    ("samoyeds",    (2, &conds[2])),
    ("pomeranians", (3, &conds[3])),
    ("akitas",      (0, &conds[4])),
    ("vizslas",     (0, &conds[5])),
    ("goldfish",    (5, &conds[6])),
    ("trees",       (3, &conds[7])),
    ("cars",        (2, &conds[8])),
    ("perfumes",    (1, &conds[9]))
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
