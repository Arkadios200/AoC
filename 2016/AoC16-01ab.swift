struct Point: Equatable, Hashable {
  var x: Int
  var y: Int
  var dir: Int = 0
  var mDist: Int { return abs(x) + abs(y) }

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }

  mutating func turn(_ d: Character) {
    switch d {
      case "L": dir = (dir + 3) % 4
      case "R": dir = (dir + 1) % 4
      default: break
    }
  }

  mutating func step() {
    switch dir {
      case 0: self.y += 1
      case 1: self.x += 1
      case 2: self.y -= 1
      case 3: self.x -= 1
      default: break
    }
  }
}

let input: [(Character, Int)] = readLine()!.split { !($0.isNumber || $0.isLetter) }.map {
  return ($0.first!, Int($0.dropFirst())!)
}

var pos = Point(0, 0)
var record: Set<Point> = [pos]
var found1 = false, found2 = false

while !found1 || !found2 {
  for (dir, dist) in input {
    pos.turn(dir)
    for _ in 1...dist {
      pos.step()
      if !found2 && !record.insert(pos).inserted {
        let ans2 = pos.mDist
        print("Part 2 answer: \(ans2)")
        found2 = true
      }
    }
  }

  if !found1 {
    let ans1 = pos.mDist
    print("Part 1 answer: \(ans1)")
    found1 = true
  }
}