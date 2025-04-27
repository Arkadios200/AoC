func getLines() -> [[Int]] {
  var input = [[Int]]()
  while let line = readLine() {
    input.append(line.split(separator: " ").map { Int($0)! })
  }

  return input
}

func convert(_ input: [[Int]]) -> [[Int]] {
  var out = [[Int]]()
  for i in input.indices.filter( { $0 % 3 == 0 } ) {
    for j in 0..<3 {
      out.append(input[i...i+2].map { $0[j] })
    }
  }

  return out
}

func validTriangles(in input: [[Int]]) -> Int {
  return input.filter { (2 * $0.max()!) < $0.reduce(0, +) }.count
}

let input1 = getLines()
let input2 = convert(input1)

print("Part 1 answer: \(validTriangles(in: input1))")
print("Part 2 answer: \(validTriangles(in: input2))")
