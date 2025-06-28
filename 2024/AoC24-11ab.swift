extension Optional where Wrapped == Int {
  mutating func combine(_ n: Int) {
    self = (self ?? 0) + n
  }
}

extension Collection where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0].combine(1) }

    return contents
  }
}

func calc(_ stones: [Int: Int], loops: Int) -> Int {
  var stones = stones

  for _ in 1...loops {
    var next: [Int: Int] = [:]
    for n in stones.keys {
      let s = Array(String(n))
      if n == 0 {
        next[1].combine(stones[n]!)
      } else if s.count % 2 == 0 {
        [s[..<(s.count/2)], s[(s.count/2)...]].map { Int(String($0))! }
          .forEach { next[$0].combine(stones[n]!) }
      } else {
        next[n * 2024].combine(stones[n]!)
      }
    }

    stones = next
  }

  return stones.values.reduce(0, +)
}

let stones = readLine()!.split(separator: " ").map { Int($0)! }.contents

let ans1 = calc(stones, loops: 25)
print("Part 1 answer: \(ans1)")

let ans2 = calc(stones, loops: 75)
print("Part 2 answer: \(ans2)")