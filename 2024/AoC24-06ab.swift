struct Point: Equatable, Hashable {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  func isWithin(_ bounds: Point) -> Bool {
    return (0..<bounds.x).contains(self.x) && (0..<bounds.y).contains(self.y)
  }
}

struct Sentry: Equatable, Hashable {
  var pos: Point
  var dir: Int = 0
  var nextPos: Point {
    return pos + [
      Point(x: 0, y: -1),
      Point(x: 1, y: 0),
      Point(x: 0, y: 1),
      Point(x: -1, y: 0),
    ][dir]
  }

  init(pos: Point) {
    self.pos = pos
  }

  mutating func turn() {
    dir = (dir + 1) % 4
  }

  mutating func step(_ obstacles: Set<Point>) -> Point {
    while obstacles.contains(self.nextPos) { self.turn() }

    self.pos = self.nextPos
    return self.pos
  }
}

func getInput() -> (Sentry, Set<Point>, Point) {
  var grid: [[Character]] = []
  while let line = readLine() { grid.append(Array(line)) }

  var sentry: Sentry? = nil
  var obstacles: Set<Point> = []
  for (i, line) in grid.enumerated() {
    for (j, c) in line.enumerated() {
      switch c {
        case "^": sentry = Sentry(pos: Point(x: j, y: i))
        case "#": obstacles.insert(Point(x: j, y: i))
        default: break
      }
    }
  }

  guard sentry != nil else { fatalError() }

  let bounds = Point(x: grid.first!.count, y: grid.count)

  return (sentry!, obstacles, bounds)
}

func part1(_ sentry: Sentry, _ obstacles: Set<Point>, _ bounds: Point) -> Set<Point> {
  var sentry = sentry

  var path: Set<Point> = []
  while sentry.step(obstacles).isWithin(bounds) {
    path.insert(sentry.pos)
  }

  return path
}

func part2(_ sentry: Sentry, _ obstacles: Set<Point>, _ bounds: Point, _ path: Set<Point>) -> Int {
  var n = 0
  for p in path {
    var obstacles = obstacles
    obstacles.insert(p)

    var sentry = sentry
    var vels: Set<Sentry> = []

    while sentry.step(obstacles).isWithin(bounds) {
      if !vels.insert(sentry).inserted {
        n += 1
        break
      }
    }
  }

  return n
}

let (sentry, obstacles, bounds) = getInput()

let path = part1(sentry, obstacles, bounds)
let ans2 = part2(sentry, obstacles, bounds, path)
print("Part 1 answer:", path.count)
print("Part 2 answer:", ans2)
