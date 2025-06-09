// Tuples in Swift are Equatable, but not Hashable, and they can't be extended.
// Basically, they can't be used in Sets. :/
struct Point: Equatable, Hashable {
  private var x: Int
  private var y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  mutating func move(_ c: Character) -> Point {
    switch c {
      case "^": self.y += 1
      case ">": self.x += 1
      case "v": self.y -= 1
      case "<": self.x -= 1
      default: fatalError("Invalid input")
    }

    return self
  }
}

func part1(_ input: String) -> Int {
  var pos = Point(0, 0)
  var posRecord: Set = [pos]

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
      case 0: posRecord.insert(santaPos.move(c))
      case 1: posRecord.insert(roboSantaPos.move(c))
      default: fatalError("Something broke")
    }
  }

  return posRecord.count
}

let input = readLine()!

let ans1 = part1(input)
print("Part 1 answer: \(ans1)")

let ans2 = part2(input)
print("Part 2 answer: \(ans2)")