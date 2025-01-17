func * (a: Int, b: [Int]) -> [Int] {
  var out = [Int]()
  for i in b {
    out += [Int](repeating: i, count: a)
  }
  return out
}

let input = Array(readLine()!).map( { Int(String($0))! } )

let pattern = [0, 1, 0, -1]

var seqs = [[Int]]()
seqs.append(input)

for _ in 1...100 {
  var newSeq = [Int]()
  for i in 0..<input.count {
    var tempPattern = (i + 1) * pattern

    var temp = 0
    for i in 0..<seqs.last!.count {
      temp += seqs.last![i] * tempPattern[(i + 1) % tempPattern.count]
    }
    newSeq.append(abs(temp % 10))
  }
  seqs.append(newSeq)
}

print(Array(seqs.last![0..<8]))
