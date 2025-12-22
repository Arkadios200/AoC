extension Array {
  func get(at i: Index) -> Element? {
    return self.indices.contains(i) ? self[i] : nil
  }
}

func getInput() -> [[Character]] {
  var grid: [[Character]] = []
  while let line = readLine() {
    grid.append(Array(line))
  }

  return grid
}

func part1(_ grid: [[Character]]) -> Int {
  let adjs = [
    (-1, -1),
    (-1, 0),
    (-1, 1),
    (0, 1),
    (1, 1),
    (1, 0),
    (1, -1),
    (0, -1),
  ]

  var ans = 0
  for i in grid.indices {
    for j in grid[i].indices where grid[i][j] == "X" {
      ans += adjs.map {
        let (a, b) = $0
        return String((0...3).compactMap { grid.get(at: i + $0*a)?.get(at: j + $0*b) })
      }.filter { ["XMAS", "SAMX"].contains($0) }.count
    }
  }

  return ans
}

func part2(_ grid: [[Character]]) -> Int {
  let r = -1...1

  var ans = 0
  for i in grid.indices {
    for j in grid[i].indices where grid[i][j] == "A" {
      let a = zip(r, r).compactMap { grid.get(at: i + $0.0)?.get(at: j + $0.1) }
      let b = zip(r, r.reversed()).compactMap { grid.get(at: i + $0.0)?.get(at: j + $0.1) }

      if [a, b].map( { String($0) } ).allSatisfy( { ["MAS", "SAM"].contains($0) } ) {
        ans += 1
      }
    }
  }

  return ans
}

let grid = getInput()

print("Part 1 answer:", part1(grid))
print("Part 2 answer:", part2(grid))