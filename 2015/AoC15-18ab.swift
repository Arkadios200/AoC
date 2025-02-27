// Needs improvement

func conwayStep(_ grid: [[Int]]) -> [[Int]] {
  var newGrid = grid
  for i in grid.indices {
    for j in grid[i].indices {
      var count = 0
      for k in -1...1 {
        for l in -1...1 {
          if grid.indices.contains(i + k) && grid[i].indices.contains(j + l) && !(k == 0 && l == 0) {
            count += grid[i+k][j+l]
          }
        }
      }

      if grid[i][j] == 1 {
        if !(2...3).contains(count) {
          newGrid[i][j] = 0
        }
      } else {
        if count == 3 {
          newGrid[i][j] = 1
        }
      }
    }
  }

  return newGrid
}

var grid = [[Int]]()
while let line = readLine() {
  if line == "" { break }
  grid.append(line.map( { $0 == "#" ? 1 : 0 } ))
}

var grid1 = grid
for _ in 1...100 {
  grid1 = conwayStep(grid1)
}

var total1 = 0
grid1.forEach( { total1 += $0.reduce(0, +) } )

print(total1)

var grid2 = grid
grid2[0][0] = 1
grid2[0][99] = 1
grid2[99][0] = 1
grid2[99][99] = 1
for _ in 1...100 {
  grid2 = conwayStep(grid2)
  grid2[0][0] = 1
  grid2[0][99] = 1
  grid2[99][0] = 1
  grid2[99][99] = 1
}

var total2 = 0
grid2.forEach( { total2 += $0.reduce(0, +) } )
print(total2)
