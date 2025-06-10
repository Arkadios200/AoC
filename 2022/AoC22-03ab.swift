let priorities = Array(" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

func getInput() -> [[Character]] {
  var lines: [[Character]] = []
  while let line = readLine() { lines.append(Array(line)) }

  return lines
}

let rucksacks = getInput()

let ans1 = rucksacks.map { ($0[..<($0.count/2)], $0[($0.count/2)...]) }.reduce(0) {
  let (a, b) = $1
  return $0 + priorities.firstIndex { a.contains($0) && b.contains($0) }!
}
print("Part 1 answer: \(ans1)")

let ans2 = rucksacks.indices.filter { $0 % 3 == 0 }.map { rucksacks[$0..<$0+3] }.reduce(0) {
  (acc, v) in
  acc + priorities.firstIndex { c in v.allSatisfy { $0.contains(c) } }!
}
print("Part 2 answer: \(ans2)")