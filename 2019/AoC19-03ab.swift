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

func oxygenGeneratorRating(_ lines: [[Character]]) -> Int {
  var temp = lines
  for i in lines[0].indices {
    var count = 0
    temp.forEach( {
      count += $0[i] == "1" ? 1 : -1
    } )
    temp = temp.filter( { $0[i] == (count >= 0 ? "1" : "0") } )
    if temp.count == 1 { break }
  }

  return Int(String(temp.first!), radix: 2)!
}

func CO2ScrubberRating(_ lines: [[Character]]) -> Int {
  var temp = lines
  for i in lines[0].indices {
    var count = 0
    temp.forEach( {
      count += $0[i] == "1" ? 1 : -1
    } )
    temp = temp.filter( { $0[i] == (count >= 0 ? "0" : "1") } )
    if temp.count == 1 { break }
  }

  return Int(String(temp.first!), radix: 2)!
}  

var lines = [[Character]]()
while let line = readLine() {
  if line == "" { break }
  lines.append(Array(line))
}

let (gamma, epsilon) = part1(lines)
print("Part 1 answer: \(gamma * epsilon)")

print("Part 2 answer: \(oxygenGeneratorRating(lines) * CO2ScrubberRating(lines))")
