var groups = [[String]]()
var temp = [String]()
while let line = readLine() {
  if line == "" {
    groups.append(temp)
    temp.removeAll()
  } else {
    temp.append(line)
  }
}

var total1 = 0
var total2 = 0
for group in groups {
  var s1 = ""
  part1: for g in group {
    for i in g.indices where !s1.contains(g[i]) {
      s1.append(g[i])
    }
  }
  total1 += s1.count

  var s2 = ""
  part2: for i in group[0].indices {
    var found = false
    for line in group {
      if !line.contains(group[0][i]) {
        found = true
        break
      }
    }
    if !found { s2.append(group[0][i]) }
  }
  total2 += s2.count
}
print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
