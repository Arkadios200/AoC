extension Collection {
  func minBy<K: Comparable>(key: (Element) -> K) -> Element? {
    return self.min { key($0) < key($1) }
  }

  func tupleWindows() -> [(Element, Element)] {
    return Array(zip(self, self.dropFirst()))
  }
}

struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  var adjs: [Point] {
    return [
      (0, 1),
      (1, 1),
      (1, 0),
      (1, -1),
      (0, -1),
      (-1, -1),
      (-1, 0),
      (-1, 1)
    ].map { self + Point(x: $0.0, y: $0.1) }
  }

  func mDist(from other: Point) -> Int {
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

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static let origin: Point = Point(x: 0, y: 0)
}

func getInput() -> [(Character, Int)] {
  var dirs: [(Character, Int)] = []
  while let line = readLine() {
    let temp = line.split(separator: " ", maxSplits: 1).map { String($0) }
    guard temp[0].count == 1 else { fatalError("Invalid input: \(line)") }

    dirs.append((Character(temp[0]), Int(temp[1])!))
  }

  return dirs
}

func calc(_ dirs: [(Character, Int)], len: Int) -> Int {
  var record: Set<Point> = []
  var rope: [Point] = [Point](repeating: Point.origin, count: len)

  record.insert(rope.last!)

  for (dir, dist) in dirs {
    for _ in 0..<dist {
      rope[0].step(dir)
      for (i, (a, b)) in zip(1..., rope.tupleWindows()) {
        if abs(a.x - b.x) > 1 || abs(a.y - b.y) > 1 {
          rope[i] = b.adjs.minBy { $0.mDist(from: a) }!
        }
      }

      record.insert(rope.last!)
    }
  }

  return record.count
}

let dirs: [(Character, Int)] = getInput()

print("Part 1 answer:", calc(dirs, len: 2))
print("Part 2 answer:", calc(dirs, len: 10))