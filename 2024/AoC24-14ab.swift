import struct Foundation.URL

let width = 101
let height = 103

struct Robot: Equatable, Hashable {
  var pos: (x: Int, y: Int)
  let vel: (x: Int, y: Int)

  init(pos: (Int, Int), vel: (Int, Int)) {
    self.pos = pos
    self.vel = vel
  }

  mutating func step() {
    pos.x = (pos.x + vel.x + width) % width
    pos.y = (pos.y + vel.y + height) % height
  }

  static func == (lhs: Robot, rhs: Robot) -> Bool {
    return lhs.pos.x == rhs.pos.x && lhs.pos.y == rhs.pos.y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(pos.x)
    hasher.combine(pos.y)
  }
}

func part1(_ robots: [Robot]) -> Int {
  var robots = robots

  for _ in 1...100 {
    robots.indices.forEach { robots[$0].step() }
  }

  return [
    robots.filter { $0.pos.x < width / 2 && $0.pos.y < height / 2 }.count,
    robots.filter { $0.pos.x < width / 2 && $0.pos.y > height / 2 }.count,
    robots.filter { $0.pos.x > width / 2 && $0.pos.y < height / 2 }.count,
    robots.filter { $0.pos.x > width / 2 && $0.pos.y > height / 2 }.count,
  ].reduce(1, *)
}

func part2(_ robots: [Robot]) -> Int {
  var robots = robots

  var i = 0
  while robots.count != Set(robots).count {
    i += 1
    robots.indices.forEach { robots[$0].step() }
  }

  return i
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

var robots: [Robot] = input.split(separator: "\n").map {
  let nums = $0.split { !"-0123456789".contains($0) }.map { Int($0)! }
  return Robot(pos: (nums[0], nums[1]), vel: (nums[2], nums[3]))
}

let ans1 = part1(robots)
let ans2 = part2(robots)

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)
