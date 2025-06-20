import struct Foundation.URL

struct Point: Equatable, Hashable {
  var x: Int
  var y: Int
  let label: Character

  init(x: Int, y: Int, label: Character = ".") {
    self.x = x
    self.y = y
    self.label = label
  }

  static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

func process(_ input: [String]) -> Set<Point> {
  var points: Set<Point> = []
  for line in input {
    let coords: [(x: Int, y: Int)] = line.split { !"0123456789,".contains($0) }.map {
      let v = $0.split(separator: ",").map { Int($0)! }
      return (v[0], v[1])
    }

    for (a, b) in coords.indices.dropLast().map( { (coords[$0], coords[$0+1]) } ) {

      if a.x != b.x {
        (min(a.x, b.x)...max(a.x, b.x))
          .forEach { points.insert(Point(x: $0, y: a.y, label: "#")) }
      } else if a.y != b.y {
        (min(a.y, b.y)...max(a.y, b.y))
          .forEach { points.insert(Point(x: a.x, y: $0, label: "#")) }
      }
    }
  }

  return points
}

func part1(_ points: Set<Point>) -> Int {
  var points = points
  outer: while true {
    var sand = Point(x: 500, y: 0, label: "o")
    while true {
      if sand.y > points.map( { $0.y } ).max()! {
        break outer
      } else if !points.contains(Point(x: sand.x, y: sand.y+1)) {
        sand.y += 1
      } else if !points.contains(Point(x: sand.x-1, y: sand.y+1)) {
        sand.x -= 1
        sand.y += 1
      } else if !points.contains(Point(x: sand.x+1, y: sand.y+1)) {
        sand.x += 1
        sand.y += 1
      } else {
        points.insert(sand)
        break
      }
    }
  }

  return points.filter { $0.label == "o" }.count
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))
.split(separator: "\n").map { String($0) }

let points = process(input)

let ans1 = part1(points)
print("Part 1 answer: \(ans1)")

/*
// Layout generator
var pos = Array(points)
let n = pos.map { $0.x }.min()!
pos.indices.forEach { pos[$0].x -= n }

var layout = [[Character]](repeating: [Character](repeating: ".", count: pos.map { $0.x }.max()! + 1), count: pos.map { $0.y }.max()! + 1)
for p in pos {
  layout[p.y][p.x] = p.label
}

try String(layout.joined(separator: "\n")).write(to: URL(fileURLWithPath: "output.txt"), atomically: true, encoding: String.Encoding.utf8)

print("done")
*/