typealias Grid = [[Int]]

func getInput() -> [(id: Int, Range<Int>, Range<Int>)] {
  var lines: [(id: Int, Range<Int>, Range<Int>)] = []
  while let line = readLine() {
    let temp = String(line.map { $0.isNumber ? $0 : " " })
      .split(separator: " ")
      .map { Int($0)! }

    let id = temp[0]
    let xRange = temp[1]..<(temp[1] + temp[3])
    let yRange = temp[2]..<(temp[2] + temp[4])

    lines.append((id, xRange, yRange))
  }

  return lines
}

func layout(_ lines: [(Int, Range<Int>, Range<Int>)]) -> Grid {
  var grid: Grid = [[Int]](repeating: [Int](repeating: 0, count: 1001), count: 1001)

  for (_, xRange, yRange) in lines {
    for i in yRange {
      for j in xRange {
        grid[i][j] += 1
      }
    }
  }

  return grid
}

let lines = getInput()

let grid = layout(lines)

let ans1 = grid.joined().filter { $0 >= 2 }.count
print("Part 1 answer: \(ans1)")

let ans2 = lines.first {
  let (_, xRange, yRange) = $0

  return grid[yRange].map { $0[xRange] }.joined().allSatisfy { $0 == 1 }
}!.id

print("Part 2 answer: \(ans2)")