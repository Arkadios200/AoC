func getInput() -> [[Int]] {
  var lines: [[Int]] = []
  while let line = readLine() {
    lines.append(line.split(separator: "\t").map { Int($0)! })
  }

  return lines
}

let lines = getInput()

let ans1 = lines.reduce(0) { $0 + $1.max()! - $1.min()! }
print("Part 1 answer: \(ans1)")

let ans2 = lines.reduce(0) {
  (acc, line) in
  for a in line {
    if let b = line.first(where: { b in a % b == 0 && a != b } ) {
      return acc + (a / b)
    }
  }
  
  return acc
}
print("Part 2 answer: \(ans2)")