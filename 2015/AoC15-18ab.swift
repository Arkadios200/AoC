typealias Grid = [[Int]]

func getInput() -> Grid {
  var grid: Grid = []
  while let line = readLine() {
    grid.append(line.map { $0 == "#" ? 1 : 0 })
  }

  return grid
}

func step(_ grid: inout Grid) {
  var newGrid = grid

  let gi = grid.indices
  let gfi = grid.first!.indices
  for i in gi {
    let yRange = max(i-1, 0)...min(i+1, gi.last!)
    for j in gfi {
      let xRange = max(j-1, 0)...min(j+1, gfi.last!)

      let temp = grid[yRange].map { $0[xRange] }.joined().reduce(0, +)
      switch grid[i][j] {
        case 1 where !(2...3).contains(temp - 1):
          newGrid[i][j] = 0
        case 0 where temp == 3:
          newGrid[i][j] = 1
        default: break
      }
    }
  }

  grid = newGrid
}

let grid = getInput()

let (sx, ex) = (grid.first!.indices.first!, grid.first!.indices.last!)
let (sy, ey) = (grid.indices.first!, grid.indices.last!)
 z 
var grid1 = grid
var grid2 = grid
for _ in 1...100 {
  step(&grid1)

  grid2[sy][sx] = 1
  grid2[sy][ex] = 1
  grid2[ey][sx] = 1
  grid2[ey][ex] = 1
  step(&grid2) ．
}

grid2[sy][sx] = 1
grid2[sy][ex] = 1
grid2[ey][sx] = 1
grid2[ey][ex] = 1

let ans1 = grid1.joined().reduce(0, +)
print("Part 1 answer: \(ans1)")

let ans2 = grid2.joined().reduce(0, +)
print("Part 2 answer: \(ans2)")