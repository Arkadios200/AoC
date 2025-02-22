func validTriangles(in input: [[Int]]) -> Int {
  return input.filter( { (2 * $0.max()!) < $0.reduce(0, +) } ).count
}

var input1 = [[Int]]()
while let line = readLine() {
  input1.append(line.split(separator: " ").map( { Int($0)! } ))
}

var input2 = [[Int]]()
for i in stride(from: 0, to: input1.count, by: 3) {
  for j in 0..<3 {
    var temp = [Int]()
    for k in 0..<3 {
      temp.append(input1[i+k][j])
    }
    input2.append(temp)
  }
}

print("Part 1 answer: \(validTriangles(in: input1))")
print("Part 2 answer: \(validTriangles(in: input2))")
