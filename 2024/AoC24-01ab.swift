func getInput() -> ([Int], [Int]) {
  var lists: ([Int], [Int]) = ([], [])
  while let line = readLine() {
    let temp = line.split(separator: " ").map { Int($0)! }

    lists.0.append(temp.first!)
    lists.1.append(temp.last!)
  }

  return lists
}

let lists = getInput()

let ans1 = zip(lists.0.sorted(), lists.1.sorted()).reduce(0) { $0 + abs($1.0 - $1.1) }
print("Part 1 answer: \(ans1)")

let ans2 = lists.0.reduce(0) {
  (acc, n) in
  acc + n * lists.1.filter { $0 == n }.count
}
print("Part 2 answer: \(ans2)")