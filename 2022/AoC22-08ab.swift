func getInput() -> [[Int]] {
  var grid: [[Int]] = []
  while let line = readLine() {
    grid.append(line.compactMap { $0.wholeNumberValue })
  }

  return grid
}

func part1(_ grid: [[Int]]) -> Int {
  var out = 0
  for i in grid.indices {
    for j in grid[i].indices {
      let n = grid[i][j]
      let slices: [[Int]] = [
        grid[..<i].map { $0[j] },
        Array(grid[i][..<j]),
        grid[(i+1)...].map { $0[j] },
        Array(grid[i][(j+1)...])
      ]

      out += slices.contains { $0.isEmpty || $0.allSatisfy { $0 < n } } ? 1 : 0
    }
  }

  return out
}

func part2(_ grid: [[Int]]) -> Int {
  var out = 0
  for i in grid.indices {
    for j in grid[i].indices {
      let n = grid[i][j]
      let slices: [[Int]] = [
        Array(grid[..<i].map { $0[j] }.reversed()),
        Array(grid[i][..<j].reversed()),
        grid[(i+1)...].map { $0[j] },
        Array(grid[i][(j+1)...])
      ]

      let temp = slices.map { $0.isEmpty ? 0 : (($0.firstIndex { $0 >= n } ?? $0.count-1) + 1) }.reduce(1, *)
      if out < temp { out = temp }
    }
  }

  return out
}

let grid = getInput()

let ans1 = part1(grid)
print("Part 1 answer: \(ans1)")

let ans2 = part2(grid)
print("Part 2 answer: \(ans2)")