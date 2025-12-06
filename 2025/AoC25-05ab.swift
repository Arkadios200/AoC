func getInput() -> ([ClosedRange<Int>], [Int]) {
  var ranges: [ClosedRange<Int>] = []
  while let line = readLine(), !line.isEmpty {
    let temp = line.split(separator: "-", maxSplits: 1).map { Int($0)! }

    ranges.append(temp[0]...temp[1])
  }

  var ids: [Int] = []
  while let line = readLine() {
    ids.append(Int(line)!)
  }

  return (ranges, ids)
}

func dedup(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
  let ranges = ranges.sorted { $0.lowerBound < $1.lowerBound }

  var out: [ClosedRange<Int>] = []
  for r in ranges {
    if !out.isEmpty, out.last!.overlaps(r) {
      let a = min(r.lowerBound, out.last!.lowerBound)
      let b = max(r.upperBound, out.last!.upperBound)

      out[out.index(before: out.endIndex)] = a...b
    } else { out.append(r) }
  }

  return out
}

let (ranges, ids) = getInput()

let ans1 = ids.filter { id in ranges.contains { $0.contains(id) } }.count
let ans2 = dedup(ranges).reduce(0) { $0 + $1.count }

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)