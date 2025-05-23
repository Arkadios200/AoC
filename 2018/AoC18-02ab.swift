extension Sequence where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0] = (contents[$0] ?? 0) + 1 }

    return contents
  }
}

extension Sequence where Element: Equatable {
  func hammingDistance(from other: Self) -> Int {
    return zip(self, other).filter { $0.0 != $0.1 }.count
  }
}

func getInput() -> [String] {
  var lines: [String] = []
  while let line = readLine() {
    lines.append(line)
  }

  return lines
}

func part2(_ lines: [String]) -> String? {
  for (i, line) in lines.enumerated() {
    if let s = lines.dropFirst(i+1).first(where: { $0.hammingDistance(from: line) == 1 } ) {
      return String(zip(s, line).filter { $0.0 == $0.1 }.map { $0.0 })
    }
  }

  return nil
}

let lines = getInput()

let temp = lines.map { $0.contents.values }

let ans1 = temp.filter { $0.contains(2) }.count * temp.filter { $0.contains(3) }.count
print("Part 1 answer: \(ans1)")

let ans2 = part2(lines)!
print("Part 2 answer: \(ans2)")