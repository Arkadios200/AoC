struct Point: Equatable, Hashable {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

func getInput() -> [(Point, Point)] {
  var lines: [(Point, Point)] = []
  while let line = readLine() {
    let l = line.split { !$0.isNumber }.map { Int($0)! }

    lines.append((Point(x: l[0], y: l[1]), Point(x: l[2], y: l[3])))
  }

  return lines
}

func part1(_ lines: [(Point, Point)]) -> Int {
  var points: [Point: Int] = [:]
  for (a, b) in lines where (a.x == b.x) || (a.y == b.y) {
    if a.x != b.x {
      (min(a.x, b.x)...max(a.x, b.x)).forEach {
        let p = Point(x: $0, y: a.y)
        points[p] = (points[p] ?? 0) + 1
      }
    } else if a.y != b.y {
      (min(a.y, b.y)...max(a.y, b.y)).forEach {
        let p = Point(x: a.x, y: $0)
        points[p] = (points[p] ?? 0) + 1
      }
    }
  }

  return points.values.filter { $0 > 1 }.count
}

func part2(_ lines: [(Point, Point)]) -> Int {
  var points: [Point: Int] = [:]
  for (a, b) in lines {
    if (a.x != b.x) && (a.y != b.y) {
      let xRange = min(a.x, b.x)...max(a.x, b.x)
      var yRange = Array(min(a.y, b.y)...max(a.y, b.y))
      if [a, b].max(by: { $0.x < $1.x } )! != [a, b].max(by: { $0.y < $1.y } ) { yRange.reverse() }
      for (x, y) in zip(xRange, yRange) {
        let p = Point(x: x, y: y)
        points[p] = (points[p] ?? 0) + 1
      }
    } else if a.x != b.x {
      (min(a.x, b.x)...max(a.x, b.x)).forEach {
        let p = Point(x: $0, y: a.y)
        points[p] = (points[p] ?? 0) + 1
      }
    } else if a.y != b.y {
      (min(a.y, b.y)...max(a.y, b.y)).forEach {
        let p = Point(x: a.x, y: $0)
        points[p] = (points[p] ?? 0) + 1
      }
    }
  }

  return points.values.filter { $0 > 1 }.count
}

let lines = getInput()

let ans1 = part1(lines)
print("Part 1 answer: \(ans1)")

let ans2 = part2(lines)
print("Part 2 answer: \(ans2)")