extension Collection {
  func minBy<K: Comparable>(key: (Element) -> K) -> Element? {
    return self.min { key($0) < key($1) }
  }

  func tupleWindows() -> [(Element, Element)] {
    return Array(zip(self, self.dropFirst()))
  }
}

enum Direction: Character {
  case up    = "U"
  case down  = "D"
  case right = "R"
  case left  = "L"
}

struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  var adjs: [Point] {
    return [
      ( 0, +1),
      (+1, +1),
      (+1,  0),
      (+1, -1),
      ( 0, -1),
      (-1, -1),
      (-1,  0),
      (-1, +1),
    ].map { self + Point(x: $0.0, y: $0.1) }
  }

  func mDist(from other: Point) -> Int {
    return abs(self.x - other.x) + abs(self.y - other.y)
  }

  func diagDist(from other: Point) -> Int {
    return max(abs(self.x - other.x), abs(self.y - other.y))
  }

  mutating func step(_ dir: Direction) {
    switch dir {
      case .up:    self.y += 1
      case .down:  self.y -= 1
      case .right: self.x += 1
      case .left:  self.x -= 1
    }
  }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static let origin: Point = Point(x: 0, y: 0)
}

func getInput() -> [(Direction, Int)] {
  var dirs: [(Direction, Int)] = []
  while let line = readLine() {
    dirs.append((Direction(rawValue: line.first!)!, Int(line.dropFirst(2))!))
  }

  return dirs
}

func calc(_ dirs: [(Direction, Int)], len: Int) -> Int {
  var record: Set<Point> = []
  var rope: [Point] = [Point](repeating: Point.origin, count: len)

  for (dir, dist) in dirs {
    for _ in 0..<dist {
      rope[0].step(dir)
      for (i, (a, b)) in zip(1..., rope.tupleWindows()) {
        if a.diagDist(from: b) > 1 {
          rope[i] = b.adjs.minBy { $0.mDist(from: a) }!
        }
      }

      record.insert(rope.last!)
    }
  }

  return record.count
}

let dirs: [(Direction, Int)] = getInput()

print("Part 1 answer:", calc(dirs, len:  2))
print("Part 2 answer:", calc(dirs, len: 10))