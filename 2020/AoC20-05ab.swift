var seats = [Int]()
while let line = readLine() {
  let id = Int(line.map( { "BR".contains($0) ? "1" : "0" } ).joined(), radix: 2)!
  seats.append(id)
}

print("Part 1 answer: \(seats.max()!)")

print("Part 2 answer: \((seats.min()!...seats.max()!).first(where: { !seats.contains($0) } )!)")
