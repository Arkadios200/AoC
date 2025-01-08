var map = [[Character]]()
while let line = readLine() {
  map.append(Array(line))
}

let width = map[0].count
let slopes: [(Int, Int)] = [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)]

var total = 1
for slope in slopes {
  var pos = (0, 0)
  var temp = 0
  while pos.0 < map.count {
    if map[pos.0][pos.1] == "#" {
      temp += 1
    }
    pos = (pos.0 + slope.0, (pos.1 + slope.1) % width)
  }
  total *= temp

  if slope == (1, 3) {
    print("Part 1 answer: \(temp)")
  }
}

print("Part 2 answer: \(total)")
