var seats = [Int]()
while let line = readLine() {
  let id = Int(line.map( { ($0 == "B" || $0 == "R") ? "1" : "0" } ).joined(), radix: 2)!
  seats.append(id)
}

var total1 = seats.max()!
print("Part 1 answer: \(total1)")

for i in 0...total1 {
  if seats.contains(i+1) && seats.contains(i-1) && !seats.contains(i) {
    print("Part 2 answer: \(i)")
    break
  }
}
