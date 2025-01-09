var total1 = 0
var total2 = 0
var group = [String]()
while let line = readLine() {
  if line == "" {
    var s = ""
    part1: for g in group {
      for i in g.indices where !s.contains(g[i]) {
        s.append(g[i])
      }
    }
    total1 += s.count

    s = ""
    part2: for i in group[0].indices {
      var foundInAll = true
      for g in group {
        if !g.contains(group[0][i]) {
          foundInAll = false
          break
        }
      }
      if foundInAll { s.append(group[0][i]) }
    }
    total2 += s.count

    group.removeAll()
  } else {
    group.append(line)
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
