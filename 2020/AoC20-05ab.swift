func exp(_ a: Int, _ b: Int) -> Int {
  if b == 0 {return 1}

  var out = 1
  for _ in 1...b {
    out *= a
  }

  return out
}

var seats = [Int]()
while let line = readLine() {
  let temp = Array(line)
  let row = Array(temp[0..<7].reversed())
  let col = Array(temp.reversed()[0..<3])

  var r = 0
  for i in stride(from: row.count-1, through: 0, by: -1) where row[i] == "B" {
    r += exp(2, i)
  }

  var c = 0
  for i in stride(from: col.count-1, through: 0, by: -1) where col[i] == "R" {
    c += exp(2, i)
  }

  seats.append((r * 8) + c)
}

var total1 = 0
for s in seats where s > total1 {
  total1 = s
}
print("Part 1 answer: \(total1)")

for i in 0...total1 {
  if seats.contains(i+1) && seats.contains(i-1) && !seats.contains(i) {
    print("Part 2 answer: \(i)")
    break
  }
}
