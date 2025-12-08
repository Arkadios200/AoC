import struct Foundation.URL

struct Point: Equatable, Hashable {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

func process(_ input: String) -> (Point, Set<Point>) {
  let grid: [[Character]] = input.split(separator: "\n").map { Array($0) }

  var start: Point? = nil
  var splitters: Set<Point> = []
  for i in grid.indices {
    for j in grid[0].indices {
      switch grid[i][j] {
        case "S":
          guard start == nil else { fatalError("Can't have more than one start point") }

          start = Point(x: j, y: i)
        case "^":
          splitters.insert(Point(x: j, y: i))
        default: break
      }
    }
  }

  guard start != nil else { fatalError("No start point found") }

  return (start!, splitters)
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let (start, splitters) = process(input)

let bottom = splitters.map { $0.y }.max()!

var record: [Point: Int] = [start: 1]
var ans1 = 0
while let y = record.keys.map( { $0.y } ).max(), y < bottom {
  for p in record.keys.filter( { $0.y == y } ) {
    if splitters.contains(Point(x: p.x, y: p.y + 1)) {
      ans1 += 1
      for q in [-1, 1].map( { Point(x: p.x + $0, y: p.y + 1) } ) {
        record[q] = (record[q] ?? 0) + record[p]!
      }
    } else {
      let q = Point(x: p.x, y: p.y + 1)
      record[q] = (record[q] ?? 0) + record[p]!
    }
  }
}

let ans2 = record.compactMap { $0.key.y == bottom ? $0.value : nil }.reduce(0, +)
print(ans1)
print(ans2)