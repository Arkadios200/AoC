let getFuel = { ($0 / 3) - 2 }

var total1 = 0, total2 = 0
var modules = [Int]()
while let line = readLine() {
  var m = getFuel(Int(line)!)

  total1 += m

  while m > 0 {
    total2 += m
    m = getFuel(m)
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")