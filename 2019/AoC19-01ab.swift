let getFuel = { ($0 / 3) - 2 }

var total1 = 0, total2 = 0
var modules = [Int]()
while let x = readLine() {
  let m = Int(x)!

  var temp = getFuel(m)
  total1 += temp

  while temp > 0 {
    total2 += temp
    temp = getFuel(temp)
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")