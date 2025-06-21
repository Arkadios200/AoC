struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

func getInput() -> ([Point], [(Character, Int)]) {
  var points: [Point] = []
  while let line = readLine(), !line.isEmpty {
    let temp = line.split(separator: ",").map { Int($0)! }
    points.append(Point(x: temp[0], y: temp[1]))
  }

  var lines: [(Character, Int)] = []
  while let line = readLine() {
    let temp = String(line.split(separator: " ").last!)

    let dir = temp.first!
    let coord = Int(temp.suffix(temp.count-2))!

    lines.append((dir, coord))
  }

  return (points, lines)
}

func getLayout(of points: [Point]) -> [[Character]] {
  var layout = [[Character]](repeating: [Character](repeating: " ", count: points.map { $0.x }.max()! + 1), count: points.map { $0.y }.max()! + 1)
  points.forEach { layout[$0.y][$0.x] = "█" }

  return layout
}

func part1(_ points: [Point], _ line: (Character, Int)) -> Int {
  var points = points
  let (dir, coord) = line

  switch dir {
    case "x":
      for i in points.indices where points[i].x > coord {
        points[i].x = 2 * coord - points[i].x
      }
    case "y":
      for i in points.indices where points[i].y > coord {
        points[i].y = 2 * coord - points[i].y
      }
    default: fatalError("invalid input: \(dir)")
  }

  return Set(points).count
}

func calc(_ points: [Point], _ lines: [(Character, Int)]) -> [[Character]] {
  var points = points
  for (dir, coord) in lines {
    switch dir {
      case "x":
        for i in points.indices where points[i].x > coord {
          points[i].x = 2 * coord - points[i].x
        }
      case "y":
        for i in points.indices where points[i].y > coord {
          points[i].y = 2 * coord - points[i].y
        }
      default: fatalError("invalid input: \(dir)")
    }

    points = Array(Set(points))
  }

  return getLayout(of: points)
}

let (points, lines) = getInput()

let ans1 = part1(points, lines.first!)
print("Part 1 answer: \(ans1)")

let ans2 = calc(points, lines)
print("Part 2 answer:")
ans2.forEach { print(String($0)) }