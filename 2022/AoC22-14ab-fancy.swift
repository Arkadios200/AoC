import struct Foundation.URL

extension Collection {
  func tupleWindows() -> [(Element, Element)] {
    return Array(zip(self, self.dropFirst()))
  }
}

struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }
}

struct Tile: Equatable, Hashable {
  var pos: Point
  let label: Character

  static let sand: Tile = Tile(pos: Point(x: 500, y: 0), label: "o")

  static func == (lhs: Tile, rhs: Tile) -> Bool {
    return lhs.pos == rhs.pos
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(pos)
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
  let walls: Set<Tile> = Set(walls.map { Tile(pos: $0, label: "#") })
  var record: Set<Tile> = []

  let bottom = walls.map { $0.pos.y }.max()!
  outer: while true {
    var sand = Tile.sand
    while true {
      if sand.pos.y > bottom { break outer }

      let nextPoints: [Tile] = [0, -1, 1].map { Tile(pos: sand.pos + Point(x: $0, y: 1), label: sand.label) }
      if let p = nextPoints.first(where: { !walls.contains($0) && !record.contains($0) } ) {
        sand = p
      } else {
        record.insert(sand)
        break
      }
    }
  }

  print(layout(walls.union(record)))

  return record.count
}

func part2(_ walls: Set<Point>) -> Int {
  let walls: Set<Tile> = Set(walls.map { Tile(pos: $0, label: "#") })
  var record: Set<Tile> = []

  let bottom = walls.map { $0.pos.y }.max()! + 1
  outer: while !record.contains(Tile.sand) {
    var sand = Tile.sand
    while true {
      if sand.pos.y == bottom {
        record.insert(sand)
        break
      }

      let nextPoints: [Tile] = [0, -1, 1].map { Tile(pos: sand.pos + Point(x: $0, y: 1), label: sand.label) }
      if let p = nextPoints.first(where: { !walls.contains($0) && !record.contains($0) } ) {
        sand = p
      } else {
        record.insert(sand)
        break
      }
    }
  }

  print(layout(walls.union(record)))

  return record.count
}

func layout(_ points: Set<Tile>) -> String {
  let offset = points.map { $0.pos.x }.min()!
  let temp = points.map { Tile(pos: $0.pos + Point(x: -offset, y: 0), label: $0.label) }

  let width = temp.map { $0.pos.x }.max()! + 1
  let height = temp.map { $0.pos.y }.max()! + 1

  var layout = [[Character]](repeating: [Character](repeating: ".", count: width), count: height)
  for p in temp {
    layout[p.pos.y][p.pos.x] = p.label
  }

  return String(layout.joined(separator: "\n"))
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let walls: Set<Point> = process(input)

print("Part 1 answer:", part1(walls))
print("Part 2 answer:", part2(walls))

//try String(layout.joined(separator: "\n")).write(to: URL(fileURLWithPath: "output.txt"), atomically: true, encoding: String.Encoding.utf8)