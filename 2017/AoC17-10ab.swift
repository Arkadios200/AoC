postfix operator -

extension Int {
  static postfix func - (n: Int) -> Int {
    return n - 1
  }
}

extension Array {
  func chunks(of size: Int) -> [[Element]] {
    return self.indices.compactMap {
      $0 % size == 0 ? Array(self[$0..<Swift.min($0+size, self.count)]) : nil
    }
  }
}

func part1(_ input: String) -> Int {
  let dirs = input.split(separator: ",").map { Int($0)! }

  let len = 256
  var nums = Array(0..<256)

  var skip = 0
  var i = 0
  for n in dirs {
    let r = (i..<i+n).map { $0 & len- }
    for (w, x) in zip(r.prefix(n/2), r.reversed()) {
      nums.swapAt(w, x)
    }

    i = i + n + skip
    skip += 1
  }

  return nums[0] * nums[1]
}

func knotHash(_ input: String) -> String {
  let dirs: [Int] = input.map { Int($0.asciiValue!) } + [17, 31, 73, 47, 23]

  let len = 256
  var nums = Array(0..<256)

  var skip = 0
  var i = 0
  for _ in 1...64 {
    for n in dirs {
      let r = (i..<i+n).map { $0 & len- }
      for (w, x) in zip(r.prefix(n/2), r.reversed()) {
        nums.swapAt(w, x)
      }

      i = i + n + skip
      skip += 1
    }
  }

  return nums.chunks(of: 16).reduce("") {
    let n = $1.reduce(0, ^)
    return $0 + (n < 0x10 ? "0" : "") + String(n, radix: 16)
  }
}

let input = readLine()!

print("Part 1 answer:", part1(input))
print("Part 2 answer:", knotHash(input))