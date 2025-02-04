var input = [[Character]]()
while let line = readLine() {
  input.append(Array(line))
}

var out1 = "", out2 = ""
for i in 0..<input[0].count {
  var counts = [Character: Int]()
  for j in 0..<input.count {
    let c = input[j][i]
    counts[c] = (counts[c] ?? 0) + 1
  }
  out1.append((counts.max(by: { $0.value < $1.value } )?.key) ?? "?")
  out2.append((counts.min(by: { $0.value < $1.value } )?.key) ?? "?")
}

print("Part 1 answer: \(out1)")
print("Part 2 answer: \(out2)")
