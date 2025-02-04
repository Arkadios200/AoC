func part1(_ dirs: [(String, Int)]) -> Int {
  var pos = (0, 0)
  for (direction, dist) in dirs {
    switch direction {
      case "forward":
        pos.0 += dist
      case "down":
        pos.1 += dist
      case "up":
        pos.1 -= dist
      default: break
    }
  }
  return pos.0 * pos.1
}

func part2(_ dirs: [(String, Int)]) -> Int {
  var pos = (0, 0)
  var aim = 0
  for (direction, dist) in dirs {
    switch direction {
      case "forward":
        pos.0 += dist
        pos.1 += aim * dist
      case "down":
        aim += dist
      case "up":
        aim -= dist
      default: break
    }
  }
  return pos.0 * pos.1
}

var dirs = [(String, Int)]()
while let line = readLine() {
  let temp = line.split(separator: " ")
  dirs.append((String(temp[0]), Int(temp[1])!))
}

print("Part 1 answer: \(part1(dirs))")
print("Part 2 answer: \(part2(dirs))")
