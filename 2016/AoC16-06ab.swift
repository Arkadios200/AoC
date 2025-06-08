extension Sequence where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0] = (contents[$0] ?? 0) + 1 }

    return contents
  }
}

func getInput() -> [[Character]] {
  var lines: [[Character]] = []
  while let line = readLine() {
    lines.append(Array(line))
  }

  return lines
}

let lines = getInput()

let counts = lines.first!.indices.map { j in lines.map { $0[j] }.contents }

let ans1 = String(counts.map { $0.max { $0.value < $1.value }!.key })
print("Part 1 answer: \(ans1)")

let ans2 = String(counts.map { $0.min { $0.value < $1.value }!.key })
print("Part 2 answer: \(ans2)")