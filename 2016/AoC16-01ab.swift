struct Point: Equatable, Hashable {
  var x, y: Int

  func mDist(from other: Point = origin) -> Int {
    return abs(self.x - other.x) + abs(self.y - other.y)
  }

  static let origin = Point(x: 0, y: 0)
}

struct Nav {
  var pos: Point = Point.origin
  var dir: Int = 0

  mutating func turn(_ d: Character) {
    switch d {
      case "L": dir = (dir + 3) % 4
      case "R": dir = (dir + 1) % 4
      default: fatalError()
    }
  }

  @discardableResult
  mutating func step(_ dist: Int = 1) -> Point {
    switch self.dir {
      case 0: self.pos.y += dist
      case 1: self.pos.x += dist
      case 2: self.pos.y -= dist
      case 3: self.pos.x -= dist
      default: fatalError()
    }

    return self.pos
  }
}

func part1(_ dirs: [(Character, Int)]) -> Int {
  var nav = Nav()
  for (dir, dist) in dirs {
    nav.turn(dir)
    nav.step(dist)
  }

  return nav.pos.mDist()
}

func part2(_ dirs: [(Character, Int)]) -> Int {
  var record: Set<Point> = []

  var nav = Nav()
  while true {
    for (dir, dist) in dirs {
      nav.turn(dir)
      for _ in 0..<dist {
        if !record.insert(nav.step()).inserted {
          return nav.pos.mDist()
        }
      }
    }
  }
}

let input = readLine()!

let dirs: [(Character, Int)] = input
  .split { !$0.isNumber && !$0.isLetter }
  .map { ($0.first!, Int($0.dropFirst())!) }

print("Part 1 answer:", part1(dirs))
print("Part 2 answer:", part2(dirs))