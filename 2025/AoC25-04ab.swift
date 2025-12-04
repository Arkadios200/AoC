struct Point: Equatable, Hashable {
  let x: Int
  let y: Int

  var adjs: [Point] {
    return [
      (-1, -1),
      (0, -1),
      (1, -1),
      (1, 0),
      (1, 1),
      (0, 1),
      (-1, 1),
      (-1, 0),
    ].map { self + Point(x: $0.0, y: $0.1) }
  }

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }
}

func getInput() -> Set<Point> {
  var grid: [[Character]] = []
  while let line = readLine() {
    grid.append(Array(line))
  }

  var rolls: Set<Point> = []
  for i in grid.indices {
    for j in grid[i].indices {
      if grid[i][j] == "@" {
        rolls.insert(Point(x: j, y: i))
      }
    }
  }

  return rolls
}

func calc(_ rolls: Set<Point>) -> (Int, Int) {
  var rolls = rolls
  let initialCount = rolls.count

  rolls = rolls.filter { $0.adjs.filter { rolls.contains($0) }.count >= 4 }
  let ans1 = initialCount - rolls.count

  while true {
    let next = rolls.filter { $0.adjs.filter { rolls.contains($0) }.count >= 4 }

    if rolls == next { break }
    rolls = next
  }

  let ans2 = initialCount - rolls.count

  return (ans1, ans2)
}

let rolls: Set<Point> = getInput()

let (ans1, ans2) = calc(rolls)
print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)