func val1(of line: [Int]) -> Int {
  var val = line[0] * line[1]
  for i in 0..<3 {
    val += 2 * line[i] * line[(i+1) % 3]
  }

  return val
}

func val2(of line: [Int]) -> Int {
  return 2*(line[0] + line[1]) + line.reduce(1, *)
}

var total1 = 0, total2 = 0
while let line = readLine() {
  let temp = line.split(separator: "x").map( { Int($0)! } ).sorted()

  total1 += val1(of: temp)
  total2 += val2(of: temp)
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
