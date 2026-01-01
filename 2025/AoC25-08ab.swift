extension Collection {
  func unorderedPairs() -> [(Element, Element)] {
    return Array(self.indices.dropLast().map { i in self[index(after: i)...].map { (self[i], $0) } }.joined())
  }

  func sortedBy<K: Comparable>(key: (Element) -> K) -> [Element] {
    return self.sorted { key($0) < key($1) }
  }
}

struct Point: Equatable, Hashable {
  let x, y, z: Int

  static let origin: Point = Point(x: 0, y: 0, z: 0)

  func dist(from other: Point = origin) -> Int {
    let xDist = self.x - other.x
    let yDist = self.y - other.y
    let zDist = self.z - other.z

    return xDist * xDist + yDist * yDist + zDist * zDist
  }
}

func part1(_ boxes: [Point]) -> Int {
  var circuits: [Set<Point>] = []

  for (a, b) in boxes.unorderedPairs().sortedBy(key: { $0.0.dist(from: $0.1) } ).prefix(1000) {
    let i = circuits.firstIndex { $0.contains(a) }
    let j = circuits.firstIndex { $0.contains(b) }

    if let i = i, let j = j {
      if i == j { continue }

      circuits[min(i, j)].formUnion(circuits.remove(at: max(i, j)))
    } else if let i = i {
      circuits[i].insert(b)
    } else if let j = j {
      circuits[j].insert(a)
    } else {
      circuits.append([a, b])
    }
  }

  return circuits.map { $0.count }.sorted(by: >).prefix(3).reduce(1, *)
}

func part2(_ boxes: [Point]) -> Int {
  var circuits: [Set<Point>] = []
  var count = 0

  for (a, b) in boxes.unorderedPairs().sortedBy(key: { $0.0.dist(from: $0.1) } ) {
    let i = circuits.firstIndex { $0.contains(a) }
    let j = circuits.firstIndex { $0.contains(b) }

    if let i = i, let j = j {
      if i == j { continue }

      circuits[min(i, j)].formUnion(circuits.remove(at: max(i, j)))
    } else if let i = i {
      circuits[i].insert(b)
      count += 1
    } else if let j = j {
      circuits[j].insert(a)
      count += 1
    } else {
      circuits.append([a, b])
      count += 2
    }

    if count == boxes.count {
      return a.x * b.x
    }
  }

  fatalError("Unreachable")
}

func getInput() -> [Point] {
  var points: [Point] = []
  while let line = readLine() {
    let temp = line.split(separator: ",", maxSplits: 2).map { Int($0)! }

    points.append(Point(x: temp[0], y: temp[1], z: temp[2]))
  }

  return points
}

let boxes = getInput()

print("Part 1 answer:", part1(boxes))
print("Part 2 answer:", part2(boxes))