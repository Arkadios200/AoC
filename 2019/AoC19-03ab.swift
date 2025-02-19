func part1(_ lines: [[Character]]) -> (Int, Int) {
  var gamma = "", epsilon = ""
  for i in lines[0].indices {
    var count = 0
    lines.forEach( {
      count += $0[i] == "1" ? 1 : -1
    } )

    gamma.append(count >= 0 ? "1" : "0")
    epsilon.append(count >= 0 ? "0" : "1")
  }
  return (Int(gamma, radix: 2)!, Int(epsilon, radix: 2)!)
}

func part2(_ lines: [[Character]]) -> (Int, Int) {
  var tempOGR = lines
  var tempCSR = lines
  for i in lines[0].indices {
    var count = 0

    if tempOGR.count > 1 {
      tempOGR.forEach( {
        count += $0[i] == "1" ? 1 : -1
      } )
      tempOGR = tempOGR.filter( { $0[i] == (count >= 0 ? "1" : "0") } )
    }

    if tempCSR.count > 1 {
      count = 0
      tempCSR.forEach( {
        count += $0[i] == "1" ? 1 : -1
      } )
      tempCSR = tempCSR.filter( { $0[i] == (count >= 0 ? "0" : "1") } )
    }
  }

  return (Int(String(tempOGR.first!), radix: 2)!, Int(String(tempCSR.first!), radix: 2)!)
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
