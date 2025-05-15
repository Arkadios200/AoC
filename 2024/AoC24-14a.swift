let width = 101
let height = 103

struct Robot {
  var pos: (x: Int, y: Int)
  let vel: (x: Int, y: Int)

  init(_ pos: (Int, Int), _ vel: (Int, Int)) {
    self.pos = pos
    self.vel = vel
  }

  mutating func step() {
    pos.x = (pos.x + vel.x + width) % width
    pos.y = (pos.y + vel.y + height) % height
  }
}

func getInput() -> [Robot] {
  var lines: [Robot] = []
  while let line = readLine() {
    let temp = line.split(separator: " ").map {
      $0
      .filter { "-0123456789,".contains($0) }
      .split(separator: ",").map { Int($0)! }
    }

    let pos = (temp[0].first!, temp[0].last!)
    let vel = (temp[1].first!, temp[1].last!)

    lines.append(Robot(pos, vel))
  }

  return lines
}

var robots = getInput()
var grid = [[Int]](repeating: [Int](repeating: 0, count: width), count: height)

for i in robots.indices {
  for _ in 1...100 {
    robots[i].step()
  }

  let (j, i) = robots[i].pos
  grid[i][j] += 1
}

let quadrants = [
  grid.prefix(height / 2).map { $0.prefix(width / 2) },
  grid.prefix(height / 2).map { $0.suffix(width / 2) },
  grid.suffix(height / 2).map { $0.prefix(width / 2) },
  grid.suffix(height / 2).map { $0.suffix(width / 2) }
]

let ans1 = quadrants.reduce(1) { $0 * $1.joined().reduce(0, +) }
print("Part 1 answer: \(ans1)")