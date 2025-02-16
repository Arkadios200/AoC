struct Report {
  var levels: [Int]
  var isSafe: Bool {
    get {
      let inc = (levels[0] < levels[1])
      return levels.indices[1...].allSatisfy( {
        let diff = (levels[$0] - levels[$0-1]) * (inc ? 1 : -1)
        return (1...3).contains(diff)
      } )
    }
  }
  
  init(_ levels: [Int]) {
    self.levels = levels
  }
}

func getTotal1(of reports: [Report]) -> Int {
  return reports.filter( { $0.isSafe } ).count
}

func getTotal2(of reports: [Report]) -> Int {
  return reports.filter( {
    let report = $0
    return report.isSafe ? true : report.levels.indices.map( {
      var temp = report
      temp.levels.remove(at: $0)
      return temp.isSafe
    } ).contains(true)
  } ).count
}

var reports = [Report]()
while let line = readLine() {
  reports.append(Report(line.split(separator: " ").map( { Int(String($0))! } )))
}

print("Part 1 answer: \(getTotal1(of: reports))")
print("Part 2 answer: \(getTotal2(of: reports))")
