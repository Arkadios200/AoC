extension Collection {
  func get(at index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

func getInput() -> [[Character]] {
  var grid: [[Character]] = []
  while let line = readLine() {
    grid.append(Array(line))
  }

  return grid
}

func calc(slope: (x: Int, y: Int), _ grid: [[Character]]) -> Int {
  var pos = (x: 0, y: 0)
  var out = 0

  while let v = grid.get(at: pos.y) {
    if v[pos.x] == "#" { out += 1 }

    pos = ((pos.x + slope.x) % v.count, pos.y + slope.y)
  }

  return out
}

let grid = getInput()

let ans1 = calc(slope: (3, 1), grid)

let slopes = [
  (1, 1),
  (3, 1),
  (5, 1),
  (7, 1),
  (1, 2),
]
let ans2 = slopes.reduce(1) { $0 * calc(slope: $1, grid) }

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)