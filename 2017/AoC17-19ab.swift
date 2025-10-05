import struct Foundation.URL

extension Collection {
  func get(at index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let grid: [[Character]] = input.split(separator: "\n").map(Array.init)

var x = grid[0].firstIndex(of: "|")!
var y = 0
var dir = 2

var seq: String = ""
var n = 0
while grid[y][x] != " " {
  n += 1

  if grid[y][x] == "+" {
    let adjs = [
      (y-1, x),
      (y, x+1),
      (y+1, x),
      (y, x-1),
    ]

    for (i, e) in adjs.enumerated() {
      if let c = grid.get(at: e.0)?.get(at: e.1), c != " " && i != (dir + 2) % 4 {
        dir = i
        break
      }
    }
  }

  switch dir {
    case 0: y -= 1
    case 1: x += 1
    case 2: y += 1
    case 3: x -= 1
    default: fatalError()
  }

  if grid[y][x].isLetter { seq.append(grid[y][x]) }
}

print("Part 1 answer:", seq)
print("Part 2 answer:", n)
