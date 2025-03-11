let TARGET = 36000000

func part1(_ count: Int) -> Int? {
  var houses = [Int](repeating: 0, count: count)
  outer: for elf in 1..<count {
    for i in stride(from: elf, to: count, by: elf) {
      houses[i] += 10 * elf

      if houses[i] >= TARGET {
        return i
      }
    }
  }

  return nil
}

func part2(_ count: Int) -> Int? {
  var houses = [Int](repeating: 0, count: count)
  outer: for elf in 1..<count {
    for i in 1...50 {
      let elfi = elf * i
      if elfi >= count { continue outer }

      houses[elfi] += 11 * elf

      if houses[elfi] >= TARGET {
        return elfi
      }
    }
  }

  return nil
}

var count = TARGET / 10
while let temp = part1(count) {
  count = temp
}
print("Part 1 answer: \(count)")

count = (TARGET / 11) + 1
while let temp = part2(count) {
  count = temp
}
print("Part 2 answer: \(count)")
