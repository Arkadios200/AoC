var m1 = [Int]()
while let line = readLine() {
  m1.append(Int(line)!)
}

let total1 = m1.indices[1...].filter( { m1[$0-1] < m1[$0] } ).count
print("Part 1 answer: \(total1)")

let m2 = m1.indices[2...].map( { m[$0-2...$0].reduce(0, +) } )

let total2 = m2.indices[1...].filter( { m2[$0-1] < m2[$0] } ).count
print("Part 2 answer: \(total2)")
