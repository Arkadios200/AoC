struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  static let steps: [Point] = [
    (1, 1),
    (1, -1),
    (-1, -1),
    (-1, 1),
    (0, 1),
    (1, 0),
    (0, -1),
    (-1, 0)
  ].map { Point(x: $0.0, y: $0.1) }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  func dist(from other: Point) -> Int {
    return abs(self.x - other.x) + abs(self.y - other.y)
  }

  mutating func step(_ dir: Character) {
    switch dir {
      case "U": self.y += 1
      case "D": self.y -= 1
      case "R": self.x += 1
      case "L": self.x -= 1
      default: fatalError()
    }
  }
}

func getInput() -> [(Character, Int)] {
  var dirs: [(Character, Int)] = []
  while let line = readLine(), !line.isEmpty {    
    dirs.append((line.first!, Int(line.split(separator: " ").last!)!))
  }

  return dirs
}

func calc(_ dirs: [(Character, Int)], knots: Int) -> Int {
  var record: Set<Point> = []

  var knots: [Point] = [Point](repeating: Point(x: 0, y: 0), count: knots)

  for (dir, dist) in dirs {
    for _ in 1...dist {
      knots[0].step(dir)

      for i in knots.indices.dropFirst() {
        if abs(knots[i].x - knots[i-1].x) > 1 || abs(knots[i].y - knots[i-1].y) > 1 {
          knots[i] = Point.steps.map { $0 + knots[i] }.min { $0.dist(from: knots[i-1]) < $1.dist(from: knots[i-1]) }!
        }
      }

      record.insert(knots.last!)
    }
  }

  return record.count
}

let dirs = getInput()

let ans1 = calc(dirs, knots: 2)
print("Part 1 answer: \(ans1)")

let ans2 = calc(dirs, knots: 10)
print("Part 2 answer: \(ans2)")