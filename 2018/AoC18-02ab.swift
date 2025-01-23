var input = [[Character]]()
while let line = readLine() {
  input.append(Array(line))
}

var counts = [0, 0]
for i in input {
  var charCounts = [Character: Int]()
  for c in i {
    charCounts[c] = (charCounts[c] ?? 0) + 1
  }

  counts[0] += charCounts.values.contains(2) ? 1 : 0
  counts[1] += charCounts.values.contains(3) ? 1 : 0
}
print("Part 1 answer: \(counts[0] * counts[1])")

part2: for i in 0..<input.count-1 {
  for j in i+1..<input.count {
    var diff = 0
    for k in 0..<input[i].count {
      diff += (input[i][k] != input[j][k]) ? 1 : 0
    }
    if diff == 1 {
      var out = ""
      for k in 0..<input[i].count where input[i][k] == input[j][k] {
        out.append(input[j][k])
      }
      print("Part 2 answer: \(out)")
      break part2
    }
  }
}
