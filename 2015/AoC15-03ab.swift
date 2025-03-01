// Tuples in Swift aren't Hashable, so they can't be used in sets. :/
struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.x)
    hasher.combine(self.y)
  }
}

func move(_ pos: inout Point, _ c: Character) {
  switch c {
    case "^": pos.y -= 1
    case ">": pos.x += 1
    case "v": pos.y += 1
    case "<": pos.x -= 1
    default: print("Invalid input.")
  }
}

func part1(_ input: String) -> Int {
  var pos = Point(0, 0)
  var posRecord: Set = [pos]
  for c in input {
    move(&pos, c)
    posRecord.insert(pos)
  }

  return posRecord.count
}

func part2(_ input: String) -> Int {
  var santaPos = Point(0, 0)
  var roboSantaPos = Point(0, 0)
  var posRecord: Set = [santaPos]

  for (i, c) in input.enumerated() {
    if i % 2 == 0 {
      move(&santaPos, c)
      posRecord.insert(santaPos)
    } else {
      move(&roboSantaPos, c)
      posRecord.insert(roboSantaPos)
    }
  }

  return posRecord.count
}

let input = readLine()!

print("Part 1 answer: \(part1(input))")
print("Part 2 answer: \(part2(input))")