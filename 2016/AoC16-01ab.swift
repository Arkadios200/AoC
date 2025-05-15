struct Point: Equatable, Hashable {
  var x: Int
  var y: Int
  var dir: Int = 0
  var mDist: Int { return abs(x) + abs(y) }

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }

  mutating func turn(_ d: Character) {
    switch d {
      case "L": dir = (dir + 3) % 4
      case "R": dir = (dir + 1) % 4
      default: break
    }
  }

  @discardableResult
  mutating func step(_ dist: Int = 1) -> Point {
    switch dir {
      case 0: self.y += dist
      case 1: self.x += dist
      case 2: self.y -= dist
      case 3: self.x -= dist
      default: break
    }

    return self
  }
}

func part1(_ input: [(Character, Int)]) -> Int {
  var pos = Point(0, 0)
  for (dir, dist) in input {
    pos.turn(dir)
    pos.step(dist)
  }

  return pos.mDist
}

func part2(_ input: [(Character, Int)]) -> Int {
  var pos = Point(0, 0)
  var record: Set = [pos]

  while true {
    for (dir, dist) in input {
      pos.turn(dir)
      for _ in 0..<dist {
        if !record.insert(pos.step()).inserted {
          return pos.mDist
        }
      }
    }
  }
}

let input: [(Character, Int)] = readLine()!.split { !($0.isNumber || $0.isLetter) }.map {
  return ($0.first!, Int($0.dropFirst())!)
}

let ans1 = part1(input)
print("Part 1 answer: \(ans1)")

let ans2 = part2(input)
print("Part 2 answer: \(ans2)")