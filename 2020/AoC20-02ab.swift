var total1 = 0
var total2 = 0
while let line = readLine() {
  let l = line.split(separator: " ").map( { String($0) } )

  let temp = l[0].split(separator: "-").map( { Int($0)! } )
  let range = temp[0]...temp[1]

  let c = l[1].first!
  let pass = Array(l[2])

  if range.contains(pass.filter( { $0 == c } ).count) { total1 += 1 }
  if (pass[temp[0]-1] == c) != (pass[temp[1]-1] == c) { total2 += 1 }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
