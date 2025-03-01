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

  mutating func move(_ c: Character) {
    switch c {
      case "^": self.y -= 1
      case ">": self.x += 1
      case "v": self.y += 1
      case "<": self.x -= 1
      default: print("Invalid input.")
    }
  }
}

func part1(_ input: String) -> Int {
  var pos = Point(0, 0)
  var posRecord: Set<Point> = [pos]
  for c in input {
    pos.move(c)
    posRecord.insert(pos)
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
        santaPos.move(c)
        posRecord.insert(santaPos)
      case 1:
        roboSantaPos.move(c)
        posRecord.insert(roboSantaPos)
      default: print("Something broke.")
    }
  }

  return posRecord.count
}

let input = readLine()!

print("Part 1 answer: \(part1(input))")
print("Part 2 answer: \(part2(input))")
