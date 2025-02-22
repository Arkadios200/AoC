func += (a: inout (Int, Int), b: (Int, Int)) {
  a.0 += b.0
  a.1 += b.1
}

func extrapolate(_ seq: [Int]) -> (Int, Int) {
  var seqs = [seq]
  while seqs.last!.contains(where: { $0 != 0 } ) {
    seqs.append(seqs.last!.indices[1...].map( { seqs.last![$0] - seqs.last![$0-1] } ))
  }

  for i in stride(from: seqs.count-2, through: 0, by: -1) {
    seqs[i].append(seqs[i].last! + seqs[i+1].last!)
    seqs[i].insert(seqs[i].first! - seqs[i+1].first!, at: 0)
  }

  return (seqs.first!.last!, seqs.first!.first!)
}

var total = (0, 0)
while let line = readLine() {
  let seq = line.split(separator: " ").map( { Int($0)! } )

  total += extrapolate(seq)
}

print("Part 1 answer: \(total.0)")
print("Part 2 answer: \(total.1)")
