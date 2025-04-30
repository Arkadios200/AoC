extension Collection where Element: Hashable {
  var counts: [Element: Int] {
    var counts: [Element: Int] = [:]
    self.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }

    return counts
  }
}

func getInput() -> ClosedRange<Int> {
  let input = readLine()!.split(separator: "-").map { Int($0)! }

  return input.first!...input.last!
}

let range = getInput()

let temp = range.map { Array(String($0)).map { Int(String($0))! } }
.filter {
  digits in
  digits.indices.dropLast().allSatisfy { digits[$0] <= digits[$0+1] } && Set(digits).count < 6
}

let ans1 = temp.count
print("Part 1 answer: \(ans1)")

let ans2 = temp.filter {
  $0.counts.values.contains(2)
}.count

print("Part 2 answer: \(ans2)")