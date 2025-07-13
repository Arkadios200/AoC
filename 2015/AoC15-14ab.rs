use std::fs;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();
  let reindeer: Vec<Reindeer> =   input
    .lines()
    .map(|line| Reindeer::from(line))
    .collect();

  let (ans1, ans2) = solve(&reindeer);
  println!("Part 1 answer: {ans1}");
  println!("Part 2 answer: {ans2}");
}

fn solve(reindeer: &[Reindeer]) -> (u32, u32) {
  let mut reindeer = reindeer.to_owned();

  for t in 0..2503 {
    for r in &mut reindeer { r.fly(t); }

    let max_dist = reindeer.iter()
      .map(|r| r.dist)
      .max().unwrap();

    reindeer.iter_mut()
      .filter(|r| r.dist == max_dist)
      .for_each(|r| r.score += 1);
  }

  let ans1 = reindeer.iter().map(|r| r.dist).max().unwrap();
  let ans2 = reindeer.iter().map(|r| r.score).max().unwrap();

  (ans1, ans2)
}

#[derive(Clone, Copy)]
struct Reindeer {
  speed: u32,
  flight_time: u32,
  rest_time: u32,
  dist: u32,
  score: u32
}

impl Reindeer {
  fn fly(&mut self, time_elapsed: u32) {
    let cycle_length = self.flight_time + self.rest_time;
    let current_cycle_time = time_elapsed % cycle_length;

    if current_cycle_time < self.flight_time {
      self.dist += self.speed;
    }
  }
}

impl From<&str> for Reindeer {
  fn from(s: &str) -> Reindeer {
    let mut data = s
      .split(|c: char| !c.is_digit(10))
      .filter_map(|s| if !s.is_empty() { Some(s.parse::<u32>().unwrap()) } else { None });

    Reindeer {
      speed: data.next().expect("Invalid input: {line}"),
      flight_time: data.next().expect("Invalid input: {line}"),
      rest_time: data.next().expect("Invalid input: {line}"),
      dist: 0,
      score: 0
    }
  }
}