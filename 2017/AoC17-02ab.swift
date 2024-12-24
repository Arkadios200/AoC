var total1 = 0, total2 = 0
while let x = readLine() {
  let line = x.split(separator: "\t").map( { Int($0)! } )
  total1 += line.max()! - line.min()!

  for i in 0..<line.count-1 {
    for j in i+1..<line.count {
      if line[i] % line[j] == 0 {
        total2 += (line[i] / line[j])
      } else if line[j] % line[i] == 0 {
        total2 += (line[j] / line[i])
      }
    }
  }       
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")