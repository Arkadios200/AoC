func getInput() -> [(String, ClosedRange<Int>, ClosedRange<Int>)] {
  var lines: [(String, ClosedRange<Int>, ClosedRange<Int>)] = []
  while let line = readLine() {
    let temp = line.split(separator: " ").suffix(4)

    let dir = String(temp.first!)

    let nums = temp.dropFirst().joined().split { !$0.isNumber }.map { Int($0)! }
    let xRange = nums[0]...nums[2]
    let yRange = nums[1]...nums[3]

    lines.append((dir, xRange, yRange))
  }

  return lines
}

func part1(_ lines: [(String, ClosedRange<Int>, ClosedRange<Int>)]) -> Int {
  var grid = [[Bool]](repeating: [Bool](repeating: false, count: 1000), count: 1000)

  for (dir, xRange, yRange) in lines {
    for i in yRange {
      for j in xRange {
        grid[i][j] = {
          switch dir {
            case "on": return true
            case "off": return false
            case "toggle": return !grid[i][j]
            default: fatalError("Something broke")
          }
        }()
      }
    }
  }

  return grid.joined().filter { $0 }.count
}

func part2(_ lines: [(String, ClosedRange<Int>, ClosedRange<Int>)]) -> Int {
  var grid = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)

  for (dir, xRange, yRange) in lines {
    for i in yRange {
      for j in xRange {
        grid[i][j] += {
          switch dir {
            case "on": return 1
            case "off": return grid[i][j] > 0 ? -1 : 0
            case "toggle": return 2
            default: fatalError("Something broke")
          }
        }()
      }
    }
  }

  return grid.joined().reduce(0, +)
}

let lines = getInput()

let ans1 = part1(lines)
print("Part 1 answer: \(ans1)")

let ans2 = part2(lines)
print("Part 2 answer: \(ans2)")
