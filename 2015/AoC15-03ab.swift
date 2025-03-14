// Tuples in Swift are Equatable, but not Hashable, and they can't be extended.
// Basically, they can't be used in Sets. :/
struct Point: Hashable {
  private var x: Int
  private var y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.x)
    hasher.combine(self.y)
  }

  static func += (lhs: inout Point, rhs: Point) {
    lhs.x += rhs.x
    lhs.y += rhs.y
  }

  mutating func move(_ c: Character) -> Point {
    let dirs: [Character: Point] = [
      "^": Point(0, -1),
      ">": Point(+1, 0),
      "v": Point(0, +1),
      "<": Point(-1, 0)
    ]

    self += dirs[c]!
    return self
  }
}

func part1(_ input: String) -> Int {
  var pos = Point(0, 0)
  var posRecord: Set<Point> = [pos]
  for c in input {
    posRecord.insert(pos.move(c))
  }

  return posRecord.count
}

func part2(_ input: String) -> Int {
  var santaPos = Point(0, 0)
  var roboSantaPos = Point(0, 0)
  var posRecord: Set = [santaPos]

  for (i, c) in input.enumerated() {
    switch i % 2 {
      case 0:
        posRecord.insert(santaPos.move(c))
      case 1:
        posRecord.insert(roboSantaPos.move(c))
      default: print("Something broke.")
    }
  }

  return posRecord.count
}

let input = readLine()!

print("Part 1 answer: \(part1(input))")
print("Part 2 answer: \(part2(input))")