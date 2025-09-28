extension Collection {
  var tupleCombinations: [(Element, Element)] {
    var tC: [(Element, Element)] = []
    for i in indices.dropLast() {
      tC += self[index(after: i)...].map { (self[i], $0) }
    }

    return tC
  }
}

struct Point: Equatable, Hashable {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  func isWithin(_ bounds: Point) -> Bool {
    return (0..<bounds.x).contains(self.x) && (0..<bounds.y).contains(self.y)
  }
}

extension Point {
  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static func += (lhs: inout Point, rhs: Point) {
    lhs = lhs + rhs
  }

  static func - (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
  }

  static func -= (lhs: inout Point, rhs: Point) {
    lhs = lhs - rhs
  }
}

func getInput() -> ([[Point]], Point) {
  var grid: [[Character]] = []
  while let line = readLine() { grid.append(Array(line)) }

  var antennae: [Character: [Point]] = [:]
  for (i, line) in grid.enumerated() {
    for (j, c) in line.enumerated() {
      if c != "." {
        var v: [Point] = antennae[c] ?? []
        v.append(Point(x: j, y: i))
        antennae[c] = v
      }
    }
  }

  let bounds = Point(x: grid.first!.count, y: grid.count)

  return (Array(antennae.values), bounds)
}

func part1(_ antennae: [[Point]], _ bounds: Point) -> Int {
  var antinodes: Set<Point> = []

  for v in antennae {
    for (a, b) in v.tupleCombinations {
      let diff = a - b
      antinodes.insert(a + diff)
      antinodes.insert(b - diff)
    }
  }

  return antinodes.filter { $0.isWithin(bounds) }.count
}

func part2(_ antennae: [[Point]], _ bounds: Point) -> Int {
  var antinodes: Set<Point> = []

  for v in antennae {
    for (a, b) in v.tupleCombinations {
      var a = a, b = b
      let diff = a - b
      while a.isWithin(bounds) {
        antinodes.insert(a)
        a += diff
      }
      while b.isWithin(bounds) {
        antinodes.insert(b)
        b -= diff
      }
    }
  }

  return antinodes.count
}

let (antennae, bounds) = getInput()
print(part1(antennae, bounds))
print(part2(antennae, bounds))