extension Sequence where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0] = (contents[$0] ?? 0) + 1 }

    return contents
  }
}

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

let counts = lists.1.contents
let ans2 = lists.0.reduce(0) { $0 + $1 * (counts[$1] ?? 0) }
print("Part 2 answer: \(ans2)")