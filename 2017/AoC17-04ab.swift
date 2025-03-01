func getContents(of s: String) -> [Character: Int] {
  var counts = [Character: Int]()
  s.forEach( { counts[$0] = (counts[$0] ?? 0) + 1 } )
  return counts
}

var passphrases = [[String]]()
while let line = readLine() {
  passphrases.append(line.split(separator: " ").map( { String($0) } ))
}

let total1 = passphrases.filter( { $0.count == Set($0).count } ).count

let total2 = passphrases.filter( {
  let temp = $0.map( { getContents(of: $0) } )
  return temp.count == Set(temp).count
} ).count

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")