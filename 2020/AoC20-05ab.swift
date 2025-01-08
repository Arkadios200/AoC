func getSeatID(of pass: String) -> Int {
  let temp = Array(pass)
  let row = Int(temp[0..<7].map( { ($0 == "B" ? "1" : "0") } ).joined(), radix: 2)!
  let col = Int(temp[7..<10].map( { ($0 == "R" ? "1" : "0") } ).joined(), radix: 2)!

  return (row * 8) + col
}

var seats = [Int]()
while let line = readLine() {
  seats.append(getSeatID(of: line))
}

var total1 = seats.max()!
print("Part 1 answer: \(total1)")

for i in 0...total1 {
  if seats.contains(i+1) && seats.contains(i-1) && !seats.contains(i) {
    print("Part 2 answer: \(i)")
    break
  }
}
