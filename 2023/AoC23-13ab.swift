typealias Grid = [[Character]]

func getInput() -> [Grid] {
  var grids: [Grid] = []

  var grid: Grid = []
  while let line = readLine() {
    if line == "" {
      grids.append(grid)
      grid.removeAll()

      continue
    }

    grid.append(Array(line))
  }

  if !grid.isEmpty { grids.append(grid) }

  return grids
}

func transpose(_ grid: Grid) -> Grid? {
  guard grid.allSatisfy( { $0.count == grid.first!.count } ) else { return nil }

  return grid.first!.indices.map {
    i in grid.map { $0[i] }
  }
}

func findLine(in grid: Grid, dist: Int = 0) -> Int? {
  return grid.indices.dropFirst().first {
    let g = [Array(grid[..<$0].reversed()), Array(grid[$0...])]

    let d = g.min(by: { $0.count < $1.count } )!.indices
    .reduce(0) {
      (acc, i) in 
      acc + g[0][i].indices.filter { g[0][i][$0] != g[1][i][$0] }.count
    }

    return d == dist
  }
}

let grids = getInput()

let ans1 = grids.reduce(0) {
  (acc, grid) in
  let n = findLine(in: grid)

  return acc + (n != nil ? 100 * n! : findLine(in: transpose(grid)!)!)
}

print("Part 1 answer: \(ans1)")


let ans2 = grids.reduce(0) {
  (acc, grid) in
  let n = findLine(in: grid, dist: 1)

  return acc + (n != nil ? 100 * n! : findLine(in: transpose(grid)!, dist: 1)!)
}

print("Part 2 answer: \(ans2)")