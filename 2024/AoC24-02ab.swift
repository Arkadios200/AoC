struct Report {
  var levels: [Int]
  
  init(_ levels: [Int]) {
    self.levels = levels
  }

  func isSafe() -> Bool {
    let inc = (levels[0] <= levels[1])
    return levels.indices[1...].allSatisfy( {
      let diff = (levels[$0] - levels[$0-1]) * (inc ? 1 : -1)
      return (1...3).contains(diff)
    } )
  }
}

func getTotal1(of reports: [Report]) -> Int {
  return reports.filter( { $0.isSafe() } ).count
}

func getTotal2(of reports: [Report]) -> Int {
  return reports.filter( {
    var safe = $0.isSafe()
    if !safe {
      for i in 0..<$0.levels.count {
        var temp = $0
        temp.levels.remove(at: i)
        safe = temp.isSafe()
        if safe { break }
      }
    }
    return safe
  } ).count
}

var reports = [Report]()
while let line = readLine() {
  reports.append(Report(line.split(separator: " ").map( { Int(String($0))! } )))
}


let total1 = getTotal1(of: reports)
print("Part 1 answer: \(total1)")
let total2 = getTotal2(of: reports)
print("Part 2 answer: \(total2)")
