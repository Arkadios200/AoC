let keypad1: [[String]] = [
  ["1", "2", "3"],
  ["4", "5", "6"],
  ["7", "8", "9"]
]
var pos1 = (1, 1)

let keypad2: [[String]] = [
  [" ", " ", "1", " ", " "],
  [" ", "2", "3", "4", " "],
  ["5", "6", "7", "8", "9"],
  [" ", "A", "B", "C", " "],
  [" ", " ", "D", " ", " "]
]
var pos2 = (2, 0)

var code1 = [String]()
var code2 = [String]()
while let line = readLine() {
  for c in line {
    switch c {
      case "U" where pos1.0 > 0:
        pos1.0 -= 1
        break
      case "D" where pos1.0 < 2:
        pos1.0 += 1
        break
      case "L" where pos1.1 > 0:
        pos1.1 -= 1
        break
      case "R" where pos1.1 < 2:
        pos1.1 += 1
        break
      default:
        break
    }

    switch c {
      case "U" where pos2.0 > 0:
        if keypad2[pos2.0-1][pos2.1] != " " {
          pos2.0 -= 1
        }
        break
      case "D" where pos2.0 < 4:
        if keypad2[pos2.0+1][pos2.1] != " " {
          pos2.0 += 1
        }
        break
      case "L" where pos2.1 > 0:
        if keypad2[pos2.0][pos2.1-1] != " " {
          pos2.1 -= 1
        }
        break
      case "R" where pos2.1 < 4:
        if keypad2[pos2.0][pos2.1+1] != " " {
          pos2.1 += 1
        }
        break
      default:
        break
    }
  }

  code1.append(keypad1[pos1.0][pos1.1])
  code2.append(keypad2[pos2.0][pos2.1])
}

print("Part 1 answer: \(code1.joined())")
print("Part 2 answer: \(code2.joined())")
