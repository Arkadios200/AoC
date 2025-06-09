func getInput() -> [[Int]] {
  var lines: [[Int]] = []
  while let line = readLine() {
    lines.append(line.split(separator: "x").map { Int($0)! }.sorted())
  }

  return lines
}

let lines = getInput()

let ans1 = lines.reduce(0) {
  (acc: Int, line: [Int]) -> Int in
  acc + line[0] * line[1] + line.indices.reduce(0) { $0 + 2 * line[$1] * line[($1 + 1) % 3] }
}
print("Part 1 answer: \(ans1)")

let ans2 = lines.reduce(0) {
  (acc: Int, line: [Int]) -> Int in
  acc + 2 * (line[0] + line[1]) + line.reduce(1, *)
}
print("Part 2 answer: \(ans2)")