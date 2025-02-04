func findHorizontal(in map: [[Character]], dist: Int) -> Int? {
  var out: Int? = nil
  loop: for i in 1..<map.count {
    var j = i - 1, k = i
    var diff = 0
    while j >= 0 && k < map.count {
      for l in 0..<map[0].count {
        diff += (map[j][l] != map[k][l]) ? 1 : 0
        if diff > dist { continue loop }
      }
      j -= 1
      k += 1
    }
    if diff == dist {
      out = i * 100
      break
    }
  }
  return out
}

func findVertical(in map: [[Character]], dist: Int) -> Int {
  var newMap = [[Character]]()
  for i in 0..<map[0].count {
    var temp = [Character]()
    for j in 0..<map.count {
      temp.append(map[j][i])
    }
    newMap.append(temp)
  }
  return findHorizontal(in: newMap, dist: dist)! / 100
}

var map = [[Character]]()
var total1 = 0, total2 = 0
while let line = readLine() {
  if line == "" {
    total1 += findHorizontal(in: map, dist: 0) ?? findVertical(in: map, dist: 0)
    total2 += findHorizontal(in: map, dist: 1) ?? findVertical(in: map, dist: 1)
    map.removeAll()
  } else {
    map.append(Array(line))
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
