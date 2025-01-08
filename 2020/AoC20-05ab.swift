func exp(_ a: Int, _ b: Int) -> Int {
  if b == 0 {return 1}

  var out = 1
  for _ in 1...b {
    out *= a
  }

  return out
}

var passes = [([Character], [Character])]()
while let line = readLine() {
  let temp = Array(line)
  let r = Array(temp[0..<7].reversed())
  let c = Array(temp.reversed()[0..<3])
  passes.append((r, c))
}

var seats = [Int]()
for (row, col) in passes {
  var f = 0
  var b = 127
  for i in stride(from: row.count-1, through: 0, by: -1) {
    if row[i] == "F" {
      b -= exp(2, i)
    } else if row[i] == "B" {
      f += exp(2, i)
    }
  }

  var l = 0
  var r = 7
  for i in stride(from: col.count-1, through: 0, by: -1) {
    if col[i] == "L" {
      r -= exp(2, i)
    } else if col[i] == "R" {
      l += exp(2, i)
    }
  }

  let temp = (b * 8) + r
  seats.append(temp)
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
