var seats = [Int]()
while let line = readLine() {
  let id = Int(line.map( { "BR".contains($0) ? "1" : "0" } ).joined(), radix: 2)!
  seats.append(id)
}

seats.sort()

print("Part 1 answer: \(seats[seats.count-1])")

for i in 1...seats.count where seats[i] - seats[i-1] == 2 {
  print("Part 2 answer: \(seats[i]-1)")
  break
}
