infix operator <==: AssignmentPrecedence
func <== <T>(lhs: inout T, rhs: T) -> T {
  lhs = rhs
  return lhs
}

func getLines() -> [Int] {
  var lines = [Int]()
  while let line = readLine() {
    lines.append(Int(line)!)
  }

  return lines
}

let getFuel: (Int) -> Int = { ($0 / 3) - 2 }

let lines = getLines()

let total1 = lines.reduce(0) { $0 + getFuel($1) }
print("Part 1 answer: \(total1)")

let total2 = lines.reduce(0) {
  var n = $1
  var v = 0
  while (n <== getFuel(n)) > 0 { v += n }

  return $0 + v
}
print("Part 1 answer: \(total2)")