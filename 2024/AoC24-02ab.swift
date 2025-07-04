struct Report {
  var levels: [Int]
  var isSafe: Bool {
    let inc = (levels.first! < levels.last!) ? 1 : -1
    return levels.indices.dropLast().allSatisfy( {
      let diff = (levels[$0+1] - levels[$0]) * inc
      return (1...3).contains(diff)
    } )
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
    (report: Report) in
    report.isSafe || report.levels.indices.contains(where: {
      var temp = report
      temp.levels.remove(at: $0)
      return temp.isSafe
    } )
  } ).count
}

var reports = [Report]()
while let line = readLine() {
  reports.append(Report(line.split(separator: " ").map( { Int(String($0))! } )))
}

print("Part 1 answer: \(getTotal1(of: reports))")
print("Part 2 answer: \(getTotal2(of: reports))")
