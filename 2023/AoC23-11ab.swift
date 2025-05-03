typealias Grid = [[Character]]

extension BidirectionalCollection {
  var unorderedPairs: [(Element, Element)] {
    var out: [(Element, Element)] = []
    for (i, e) in self.dropLast().enumerated() {
      for f in self.dropFirst(i+1) {
        out.append((e, f))
      }
    }

    return out
  }
}

func getInput() -> Grid {
  var grid: Grid = []
  while let line = readLine() {
    grid.append(Array(line))
  }

  return grid
}

func findGalaxies(in grid: Grid) -> [(y: Int, x: Int)] {
  var galaxies: [(Int, Int)] = []

  for i in grid.indices {
    for j in grid[i].indices {
      if grid[i][j] == "#" {
        galaxies.append((i, j))
      }
    }
  }

  return galaxies
}

func walk(_ grid: Grid, expansion: Int) -> Int {
  let galaxies = findGalaxies(in: grid)

  let rows = grid.indices.filter { !grid[$0].contains("#") }
  let cols = grid[0].indices.filter { j in !grid.map { $0[j] }.contains("#") }

  return galaxies.unorderedPairs.reduce(0) {
    let (g1, g2) = $1

    let yRange = min(g1.y, g2.y)..<max(g1.y, g2.y)
      let xRange = min(g1.x, g2.x)..<max(g1.x, g2.x)

    return $0
    + yRange.count
    + xRange.count
    + rows.filter { yRange ~= $0 }.count * (expansion - 1)
    + cols.filter { xRange ~= $0 }.count * (expansion - 1)
  }
}

let grid = getInput()

let ans1 = walk(grid, expansion: 2)
print("Part 1 answer: \(ans1)")

let ans2 = walk(grid, expansion: 1000000)
print("Part 2 answer: \(ans2)")