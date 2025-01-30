func part1(_ input: [Character]) -> Int {
  var pos = (0, 0)
  var posRecord = [pos]
  for i in input {
    switch i {
      case "^":
        pos.1 -= 1
      case ">":
        pos.0 += 1
      case "v":
        pos.1 += 1
      case "<":
        pos.0 -= 1
      default: break
    }

    if !posRecord.contains() { $0 == pos } {
      posRecord.append(pos)
    }
  }

  return posRecord.count
}

func part2(_ input: [Character]) -> Int {
  var santaPos = (0, 0)
  var roboSantaPos = (0, 0)
  var posRecord = [santaPos]
  for (i, e) in input.enumerated() {
    if i % 2 == 0 {
      switch e {
        case "^":
          santaPos.1 -= 1
        case ">":
          santaPos.0 += 1
        case "v":
          santaPos.1 += 1
        case "<":
          santaPos.0 -= 1
        default: break
      }

      if !posRecord.contains() { $0 == santaPos } {
        posRecord.append(santaPos)
      }
    } else {
      switch e {
        case "^":
          roboSantaPos.1 -= 1
        case ">":
          roboSantaPos.0 += 1
        case "v":
          roboSantaPos.1 += 1
        case "<":
          roboSantaPos.0 -= 1
        default: break
      }

      if !posRecord.contains() { $0 == roboSantaPos } {
        posRecord.append(roboSantaPos)
      }
    }
  }

  return posRecord.count
}

let input = Array(readLine()!)

print("Part 1 answer: \(part1(input))")
print("Part 2 answer: \(part2(input))")