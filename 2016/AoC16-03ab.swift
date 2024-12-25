func numberOfValidTriangles(in input: [[Int]]) -> Int {
  var total = 0

  for i in input {
    var line = i
    let m = i.max()!

    for j in 0..<3 where line[j] == m {
      line.remove(at: j)
      break
    }

    total += (line[0] + line[1]) > m ? 1 : 0
  }

  return total
}

var input1 = [[Int]]()
while let line = readLine() {
  input1.append(line.split(separator: " ").map( { Int($0)! } ))
}

var input2 = [[Int]]()
for i in stride(from: 0, to: input1.count, by: 3) {
  for j in 0..<3 {
    var temp = [Int]()
    for k in 0...2 {
      temp.append(input1[i+k][j])
    }
    input2.append(temp)
  }
}

let total1 = numberOfValidTriangles(in: input1)
print("Part 1 answer: \(total1)")
let total2 = numberOfValidTriangles(in: input2)
print("Part 2 answer: \(total2)")