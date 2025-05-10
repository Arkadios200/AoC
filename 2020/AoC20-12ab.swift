func getInput() -> [(Character, Int)] {
  var lines: [(Character, Int)] = []
  while let line = readLine() {
    lines.append((line.first!, Int(line.dropFirst())!))
  }

  return lines
}

func step(_ pos: inout (x: Int, y: Int, dir: Int), _ dir: Character, _ dist: Int) {
  switch dir {
    case "N": pos.y += dist
    case "S": pos.y -= dist
    case "E": pos.x += dist
    case "W": pos.x -= dist
    case "R": pos.dir = (pos.dir + dist / 90) % 4
    case "L": pos.dir = (pos.dir - (dist / 90) + 4) % 4
    default: break
  }
}

func navigate1(_ lines: [(Character, Int)]) -> Int {
  var pos = (x: 0, y: 0, dir: 1)
  for (dir, dist) in lines {
    switch dir {
      case "F":
        step(&pos, ["N", "E", "S", "W"][pos.dir], dist)
      default: step(&pos, dir, dist)
    }
  }

  return abs(pos.x) + abs(pos.y)
}

func navigate2(_ lines: [(Character, Int)]) -> Int {
  var pos = (x: 0, y: 0)
  var wp = (x: 10, y: 1)

  for (dir, dist) in lines {
    switch dir {
      case "N": wp.y += dist
      case "S": wp.y -= dist
      case "E": wp.x += dist
      case "W": wp.x -= dist
      case "R":
        for _ in 1...(dist / 90) {
          let (b, c) = wp
          wp = (c, -b)
        }
      case "L":
        for _ in 1...(dist / 90) {
          let (b, c) = wp
          wp = (-c, b)
        }
      case "F":
        pos.x += wp.x * dist
        pos.y += wp.y * dist
      default: break
    }
  }

  return abs(pos.x) + abs(pos.y)
}

let lines = getInput()

let ans1 = navigate1(lines)
print("Part 1 answer: \(ans1)")

let ans2 = navigate2(lines)
print("Part 2 answer: \(ans2)")