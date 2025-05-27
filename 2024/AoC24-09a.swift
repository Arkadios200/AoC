func diskMap(from input: [Int]) -> [Int?] {
  var out: [Int?] = []

  var n = 0
  for (i, e) in input.enumerated() {
    switch i % 2 {
      case 0:
        out += [Int?](repeating: n, count: e)
        n += 1
      case 1:
        out += [Int?](repeating: nil, count: e)
      default: break
    }
  }

  return out
}

func defrag(_ disk: [Int?]) -> [Int] {
  var disk = disk

  var (a, b) = (disk.firstIndex(of: nil)!, disk.lastIndex { $0 != nil }!)

  while a < b {
    defer { b -= 1 }

    if disk[b] != nil {
      disk.swapAt(a, b)
      repeat { a += 1 } while disk[a] != nil
    }
  }

  return disk.map { $0 ?? 0 }
}

let input = readLine()!.map { $0.wholeNumberValue! }

let disk = defrag(diskMap(from: input))

let ans1 = disk.enumerated().reduce(0) { $0 + $1.0 * $1.1 }
print("Part 1 answer: \(ans1)")