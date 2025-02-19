extension String {
  var parseBin: Int? {
    return Int(self, radix: 2)
  }
}

func getCount(_ lines: [[Character]], _ i: Int) -> Int {
  var count = 0
  lines.forEach( {
    count += $0[i] == "1" ? 1 : -1
  } )

  return count
}

func part1(_ lines: [[Character]]) -> (Int, Int) {
  var gamma = "", epsilon = ""
  for i in lines[0].indices {
    let count = getCount(lines, i)

    gamma.append(count >= 0 ? "1" : "0")
    epsilon.append(count >= 0 ? "0" : "1")
  }

  return (gamma.parseBin!, epsilon.parseBin!)
}

func part2(_ lines: [[Character]]) -> (Int, Int) {
  var tempOGR = lines
  var tempCSR = lines
  for i in lines[0].indices {
    if tempOGR.count > 1 {
      tempOGR = tempOGR.filter( { $0[i] == (getCount(tempOGR, i) >= 0 ? "1" : "0") } )
    }

    if tempCSR.count > 1 {
      tempCSR = tempCSR.filter( { $0[i] == (getCount(tempCSR, i) >= 0 ? "0" : "1") } )
    }

    if tempOGR.count == 1 && tempCSR.count == 1 { break }
  }

  return (String(tempOGR.first!).parseBin!, String(tempCSR.first!).parseBin!)
}  

var lines = [[Character]]()
while let line = readLine() {
  if line == "" { break }
  lines.append(Array(line))
}

let (gamma, epsilon) = part1(lines)
print("Part 1 answer: \(gamma * epsilon)")

let (oxygenGeneratorRating, CO2ScrubberRating) = part2(lines)
print("Part 2 answer: \(oxygenGeneratorRating * CO2ScrubberRating)")
