import struct Foundation.URL

extension Collection {
  func tupleWindows() -> [(Element, Element)] {
    return Array(zip(self, self.dropFirst()))
  }
}

struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  static let newSand: Point = Point(x: 500, y: 0)

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }
}

func process(_ input: String) -> Set<Point> {
  var walls: Set<Point> = []
  for line in input.split(separator: "\n") {
    let coords: [Point] = line.split { !"0123456789,".contains($0) }.map {
      let v = $0.split(separator: ",", maxSplits: 1).map { Int($0)! }
      return Point(x: v[0], y: v[1])
    }

    for (a, b) in coords.tupleWindows() {
      if a.x != b.x {
        (min(a.x, b.x)...max(a.x, b.x))
        .forEach { walls.insert(Point(x: $0, y: a.y)) }
      } else if a.y != b.y {
        (min(a.y, b.y)...max(a.y, b.y))
        .forEach { walls.insert(Point(x: a.x, y: $0)) }
      } else { fatalError() }
    }
  }

  return walls
}

func part1(_ walls: Set<Point>) -> Int {
  var record: Set<Point> = []

  let bottom = walls.map { $0.y }.max()!
  outer: while true {
    var sand = Point.newSand
    while true {
      if sand.y > bottom { break outer }

      let nextPoints: [Point] = [0, -1, 1].map { sand + Point(x: $0, y: 1) }
      if let p = nextPoints.first(where: { !record.union(walls).contains($0) } ) {
        sand = p
      } else {
        record.insert(sand)
        break
      }
    }
  }

  return record.count
}

func part2(_ walls: Set<Point>) -> Int {
  var record: Set<Point> = []

  let bottom = walls.map { $0.y }.max()! + 1
  while !record.contains(Point.newSand) {
    var sand = Point.newSand
    while true {
      if sand.y == bottom {
        record.insert(sand)
        break
      }

      let nextPoints: [Point] = [0, -1, 1].map { sand + Point(x: $0, y: 1) }
      if let p = nextPoints.first(where: { !walls.union(record).contains($0) } ) {
        sand = p
      } else {
        record.insert(sand)
        break
      }
    }
  }

  return record.count
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let walls: Set<Point> = process(input)

print("Part 1 answer:", part1(walls))
print("Part 2 answer:", part2(walls))