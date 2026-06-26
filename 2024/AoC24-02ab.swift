extension Sequence {
  func tupleWindows() -> [(Element, Element)] {
    return Array(zip(self, self.dropFirst()))
  }
}

struct Report {
  let values: [Int]

  func isSafe(tolerance: Int = 0) -> Bool {
    let sign = values[0] < values[1] ? 1 : -1
    var check = 0
    for (a, b) in values.map( { $0 * sign } ).tupleWindows() {
      if !(1...3).contains(b - a) {
        check += 1
        if check > tolerance { return false }
      }
    }

    return true
  }
}

func getInput() -> [Report] {
  var reports: [Report] = []
  while let line = readLine() {
    let nums = line.split(separator: " ").map { Int($0)! }
    reports.append(Report(values: nums))
  }

  return reports
}

let reports = getInput()

print("Part 1 answer:", reports.filter { $0.isSafe() }.count)
print("Part 2 answer:", reports.filter { $0.isSafe(tolerance: 1) }.count)