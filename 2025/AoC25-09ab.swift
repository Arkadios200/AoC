extension Collection {
  func unorderedPairs() -> [(Element, Element)] {
    return Array(self.indices.dropLast().map { i in self[index(after: i)...].map { (self[i], $0) } }.joined())
  }

  func tupleWindows() -> [(Element, Element)] {
    return Array(zip(self, self.dropFirst()))
  }
}

struct Point {
  let x: Int
  let y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

struct Rectangle {
  let x: ClosedRange<Int>
  let y: ClosedRange<Int>

  init(x: ClosedRange<Int>, y: ClosedRange<Int>) {
    self.x = x
    self.y = y
  }

  init(a: Point, b: Point) {
    self.x = min(a.x, b.x)...max(a.x, b.x)
    self.y = min(a.y, b.y)...max(a.y, b.y)
  }

  var area: Int {
    return x.count * y.count
  }

  var inner: Rectangle? {
    guard x.count >= 2 && y.count >= 2 else { return nil }
    return Rectangle(x: x.first!+1...x.last!-1, y: y.first!+1...y.last!-1)
  }

  func overlaps(with other: Rectangle) -> Bool {
    return self.x.overlaps(other.x) && self.y.overlaps(other.y)
  }
}

func getInput() -> [Point] {
  var points: [Point] = []
  while let line = readLine() {
    let temp = line.split(separator: ",", maxSplits: 1).map { Int($0)! }

    points.append(Point(x: temp[0], y: temp[1]))
  }

  return points
}

let points: [Point] = getInput()

let rectangles: [Rectangle] = points.unorderedPairs().map { Rectangle(a: $0.0, b: $0.1) }

let ans1 = rectangles.map { $0.area }.max()!
print("Part 1 answer:", ans1)

let lines = (points + [points.first!]).tupleWindows().map { Rectangle(a: $0.0, b: $0.1) }

let ans2 = rectangles.compactMap { rect in $0.inner != nil && !lines.contains { $0.overlaps(with: rect.inner!) } ? rect.area : nil }.max()!

print("Part 2 answer:", ans2)