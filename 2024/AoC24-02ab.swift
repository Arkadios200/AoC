struct Report {
  var levels: [Int]
  
  init(_ levels: [Int]) {
    self.levels = levels
  }

  func isSafe() -> Bool {
    var safe = true
    let inc = (levels[0] <= levels[1])
    for i in 0..<(levels.count-1) {
      let diff = (levels[i+1] - levels[i]) * (inc ? 1 : -1)
      if !(diff >= 1 && diff <= 3) {
        safe = false
        break
      }
    }
    return safe
  }
}

func getTotal1(of reports: [Report]) -> Int {
  return reports.filter( { $0.isSafe() } ).count
}

func getTotal2(of reports: [Report]) -> Int {
  var total = 0
  for r in reports {
    var safe = r.isSafe()
    if !safe {
      for i in 0..<r.levels.count {
        var temp = r
        temp.levels.remove(at: i)
        safe = temp.isSafe()
        if safe { break }
      }
    }
    total += (safe ? 1 : 0)
  }

  return total
}

var reports = [Report]()
while let line = readLine() {
  reports.append(Report(line.split(separator: " ").map( { Int(String($0))! } )))
}


let total1 = getTotal1(of: reports)
print("Part 1 answer: \(total1)")
let total2 = getTotal2(of: reports)
print("Part 2 answer: \(total2)")
