typealias Grid = [[Int]]

extension Collection {
  subscript(safe index: Index) -> Element? {
    return self.indices.contains(index) ? self[index] : nil
  }
}

func getInput() -> Grid {
  var grid: Grid = []
  while let line = readLine() {
    grid.append(line.map { $0 == "#" ? 1 : 0 })
  }

  return grid
}

func part1(_ grid: Grid) -> Int {
  var grid = grid

  var record: Set<Grid> = []

  var nextGrid = grid
  while record.insert(grid).inserted {
    for i in grid.indices {
      for j in grid[i].indices {
        let n = [
          (-1, 0),
          (0, +1),
          (+1, 0),
          (0, -1)
        ].reduce(0) { $0 + (grid[safe: i+$1.0]?[safe: j+$1.1] ?? 0) }

        switch grid[i][j] {
          case 0: if (1...2).contains(n) { nextGrid[i][j] = 1 }
          case 1: if n != 1 { nextGrid[i][j] = 0 }
          default: break
        }
      }
    }

    grid = nextGrid
  }

  let temp = Array(grid.joined())

  return temp.indices.reduce(0) { $0 + (temp[$1] << $1) }
}

var grid = getInput()

let ans1 = part1(grid)
print("Part 1 answer: \(ans1)")