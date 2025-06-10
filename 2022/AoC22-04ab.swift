extension ClosedRange where Element: Comparable {
  func contains(_ other: ClosedRange<Element>) -> Bool {
    return self.lowerBound <= other.lowerBound
    && self.upperBound >= other.upperBound
  }
}

func getInput() -> [(ClosedRange<Int>, ClosedRange<Int>)] {
  var lines: [(ClosedRange<Int>, ClosedRange<Int>)] = []
  while let line = readLine() {
    let temp = line.split { !$0.isNumber }.map { Int($0)! }

    lines.append((temp[0]...temp[1], temp[2]...temp[3]))
  }

  return lines
}

let lines = getInput()

let ans1 = lines.filter {
  let (a, b) = $0
  return a.contains(b) || b.contains(a)
}.count
print(ans1)

let ans2 = lines.filter {
  let (a, b) = $0
  return a.overlaps(b)
}.count
print(ans2)