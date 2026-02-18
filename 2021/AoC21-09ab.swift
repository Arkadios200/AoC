extension Collection {
  func get(at index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

struct Point: Equatable, Hashable {
  let x, y: Int

  var adjs: [Point] {
    return [
      (-1, 0),
      (0, +1),
      (+1, 0),
      (0, -1),
    ].map { self + Point(x: $0.0, y: $0.1) }
  }

  func find(in grid: [[Int]]) -> Int? {
    return grid.get(at: y)?.get(at: x)
  }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }
}

func getInput() -> [[Int]] {
  var grid: [[Int]] = []
  while let line = readLine(), !line.isEmpty {
    grid.append(line.map { $0.wholeNumberValue! })
  }

  return grid
}

func part1(_ grid: [[Int]]) -> (Int, [Point]) {
  var out = 0
  var lowPoints: [Point] = []
  for (i, row) in zip(grid.indices, grid) {
    for (j, n) in zip(row.indices, row) {
      let adjs: [Int] = [
        (-1, 0),
        (0, +1),
        (+1, 0),
        (0, -1),
      ].compactMap { grid.get(at: i + $0.1)?.get(at: j + $0.0) }
      if adjs.allSatisfy( { $0 > n } ) {
        out += n + 1
        lowPoints.append(Point(x: j, y: i))
      }
    }
  }

  return (out, lowPoints)
}

func part2(_ grid: [[Int]], _ lowPoints: [Point]) -> Int {
  var sizes: [Int] = []
  for lP in lowPoints {
    var basin: Set<Point> = [lP]
    var checked: Set<Point> = []
    while true {
      var next: [Point] = []
      for p in basin where !checked.contains(p) {
        next += p.adjs.filter {
          guard let n = $0.find(in: grid) else { return false }
          return n >= p.find(in: grid)! && n < 9
        }
        checked.insert(p)
      }

      if next.isEmpty { break }
      for p in next { basin.insert(p) }
    }

    sizes.append(basin.count)
  }

  return sizes.sorted(by: >).prefix(3).reduce(1, *)
}

let grid: [[Int]] = getInput()

let (ans1, lowPoints) = part1(grid)
print("Part 1 answer:", ans1)

let ans2 = part2(grid, lowPoints)
print("Part 2 answer:", ans2)