func clockwise(_ a: inout (x: Int, y: Int)) {
  let (b, c) = a
  a = (c, -b)
}

func counterclockwise(_ a: inout (x: Int, y: Int)) {
  let (b, c) = a
  a = (-c, b)
}

func getInput() -> [(Character, Int)] {
  var lines: [(Character, Int)] = []
  while let line = readLine() {
    if line.isEmpty { break }
    lines.append((line.first!, Int(line.dropFirst())!))
  }

  return lines
}

func navigate1(_ lines: [(Character, Int)]) -> Int {
  var pos = (x: 0, y: 0, dir: 1)
  for (dir, dist) in lines {
    switch dir {
      case "N": pos.y += dist
      case "S": pos.y -= dist
      case "E": pos.x += dist
      case "W": pos.x -= dist
      case "R": pos.dir = (pos.dir + dist / 90) % 4
      case "L": pos.dir = (pos.dir - (dist / 90) + 4) % 4
      case "F":
        switch pos.dir {
          case 0: pos.y += dist
          case 1: pos.x += dist
          case 2: pos.y -= dist
          case 3: pos.x -= dist
          default: break
      }
      default: break
    }
  }

  return abs(pos.x) + abs(pos.y)
}

func navigate2(_ lines: [(Character, Int)]) -> Int {
  var pos = (x: 0, y: 0)
  var waypoint = (x: 10, y: 1)

  for (dir, dist) in lines {
    switch dir {
      case "N": waypoint.y += dist
      case "S": waypoint.y -= dist
      case "E": waypoint.x += dist
      case "W": waypoint.x -= dist
      case "R":
        for _ in 1...(dist / 90) {
          clockwise(&waypoint)
        }
      case "L":
        for _ in 1...(dist / 90) {
          counterclockwise(&waypoint)
        }
      case "F":
        pos.x += waypoint.x * dist
        pos.y += waypoint.y * dist
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