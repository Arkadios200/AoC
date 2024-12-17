func getFuel(_ module: Int) -> Int {
  return (module / 3) - 2
}

var modules = [Int]()
while let x = readLine() {
  modules.append(Int(x)!)
}

var total1 = 0, total2 = 0
for m in modules {
  total1 += getFuel(m)

  var temp = getFuel(m)
  while temp > 0 {
    total2 += temp
    temp = getFuel(temp)
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
