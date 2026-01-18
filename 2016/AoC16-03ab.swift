extension Collection where Element: Collection {
  func transposed() -> [[Self.Element.Element]]? {
    guard Set(self.map( { $0.count } )).count == 1 else { return nil }

    return self.first?.indices.map { j in self.map { $0[j] } }
  }
}

extension Collection where Index == Int {
  func chunks(of size: Int) -> [Self.SubSequence] {
    return self.indices.compactMap { i in i % size == 0 ? self[i..<i+size] : nil }
  }
}

struct Triangle {
  let sides: [Int]

  init?(sides: [Int]) {
    guard sides.count == 3 else { return nil }
    guard 2 * sides.max()! < sides.reduce(0, +) else { return nil }

    self.sides = sides.sorted(by: >)
  }

  init?(a: Int, b: Int, c: Int) {
    self.init(sides: [a, b, c])
  }
}

func getInput() -> ([Triangle], [Triangle]) {
  var lines1: [[Int]] = []
  while let line = readLine() {
    lines1.append(line.split(separator: " ").map { Int($0)! })
  }

  let lines2 = lines1.chunks(of: 3).map { $0.transposed()! }.joined()

  let validTriangles1: [Triangle] = lines1.compactMap { Triangle(sides: $0) }
  let validTriangles2: [Triangle] = lines2.compactMap { Triangle(sides: $0) }

  return (validTriangles1, validTriangles2)
}

let (validTriangles1, validTriangles2) = getInput()

print("Part 1 answer:", validTriangles1.count)
print("Part 2 answer:", validTriangles2.count)