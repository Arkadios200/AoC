func validTriangles(in input: [[Int]]) -> Int {
  return input.filter { (2 * $0.max()!) < $0.reduce(0, +) }.count
}

var input1 = [[Int]]()
while let line = readLine() {
  input1.append(line.split(separator: " ").map( { Int($0)! } ))
}

var input2 = [[Int]]()
for i in input1.indices.filter( { $0 % 3 == 0 } ) {
  for j in 0..<3 {
    input2.append(input1[i...i+2].map { $0[j] })
  }
}

print("Part 1 answer: \(validTriangles(in: input1))")
print("Part 2 answer: \(validTriangles(in: input2))")