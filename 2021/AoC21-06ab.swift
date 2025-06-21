extension Sequence where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0] = (contents[$0] ?? 0) + 1 }

    return contents
  }
}

func calc(_ input: [Int], loops: Int) -> Int {
  var fish = input.contents

  for _ in 1...loops {
    var next: [Int: Int] = [:]
    for (key, val) in fish {
      if key == 0 {
        next[6] = (next[6] ?? 0) + val
        next[8] = (next[8] ?? 0) + val
      } else {
        next[key-1] = (next[key-1] ?? 0) + val
      }
    }

    fish = next
  }

  return fish.values.reduce(0, +)
}

let input = readLine()!.compactMap { $0.wholeNumberValue }

let ans1 = calc(input, loops: 80)
print("Part 1 answer: \(ans1)")

let ans2 = calc(input, loops: 256)
print("Part 2 answer: \(ans2)")