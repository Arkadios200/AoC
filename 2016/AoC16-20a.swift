func getInput() -> [ClosedRange<Int>] {
  var ranges: [ClosedRange<Int>] = []
  while let line = readLine() {
    let temp = line.split(maxSplits: 1) { !$0.isNumber }.map { Int($0)! }

    ranges.append(temp.first!...temp.last!)
  }

  return ranges
}

let ranges = getInput()

let n = ranges.map { $0.upperBound + 1 }.filter { x in ranges.allSatisfy { !$0.contains(x) } }.min()!

print(n)