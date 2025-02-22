let keypad1: [[Character]] = [
  [" ", " ", " ", " ", " "],
  [" ", "1", "2", "3", " "],
  [" ", "4", "5", "6", " "],
  [" ", "7", "8", "9", " "],
  [" ", " ", " ", " ", " "]
]
var pos1 = (2, 2)

let keypad2: [[Character]] = [
  [" ", " ", " ", " ", " ", " ", " "],
  [" ", " ", " ", "1", " ", " ", " "],
  [" ", " ", "2", "3", "4", " ", " "],
  [" ", "5", "6", "7", "8", "9", " "],
  [" ", " ", "A", "B", "C", " ", " "],
  [" ", " ", " ", "D", " ", " ", " "],
  [" ", " ", " ", " ", " ", " ", " "]
]
var pos2 = (3, 1)

var code1 = ""
var code2 = ""
while let line = readLine() {
  for c in line {
    var (i, j) = pos1
    switch c {
      case "U" where keypad1[i-1][j] != " ":
        pos1.0 -= 1
      case "D" where keypad1[i+1][j] != " ":
        pos1.0 += 1
      case "L" where keypad1[i][j-1] != " ":
        pos1.1 -= 1
      case "R" where keypad1[i][j+1] != " ":
        pos1.1 += 1
      default: break
    }

    (i, j) = pos2
    switch c {
      case "U" where keypad2[i-1][j] != " ":
        pos2.0 -= 1
      case "D" where keypad2[i+1][j] != " ":
        pos2.0 += 1
      case "L" where keypad2[i][j-1] != " ":
        pos2.1 -= 1
      case "R" where keypad2[i][j+1] != " ":
        pos2.1 += 1
      default: break
    }
  }
  code1.append(keypad1[pos1.0][pos1.1])
  code2.append(keypad2[pos2.0][pos2.1])
}

print(code1)
print(code2)