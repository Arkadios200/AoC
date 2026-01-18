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

    self.sides = sides.sorted(by: >)
  }

  init(a: Int, b: Int, c: Int) {
    self.init(sides: [a, b, c])!
  }

  var isValid: Bool {
    return 2 * sides[0] < sides.reduce(0, +)
  }
}

func getInput() -> ([Triangle], [Triangle]) {
  var lines1: [[Int]] = []
  while let line = readLine() {
    lines1.append(line.split(separator: " ").map { Int($0)! })
  }

  let lines2 = lines1.chunks(of: 3).map { $0.transposed()! }.joined()

  let triangles1: [Triangle] = lines1.map { Triangle(sides: $0)! }
  let triangles2: [Triangle] = lines2.map { Triangle(sides: $0)! }

  return (triangles1, triangles2)
}

let (triangles1, triangles2) = getInput()

print("Part 1 answer:", triangles1.filter { $0.isValid }.count)
print("Part 2 answer:", triangles2.filter { $0.isValid }.count)