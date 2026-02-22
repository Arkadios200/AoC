postfix operator +

extension Int {
  static postfix func + (n: Int) -> Int {
    return n + 1
  }
}

extension Array {
  mutating func retain(_ cond: (Element) -> Bool) {
    self = self.filter(cond)
  }
}

struct Lens {
  let label: String
  var focalLength: Int

  init(_ label: String, _ focalLength: Int) {
    self.label = label
    self.focalLength = focalLength
  }
}

func hashAlg(_ s: String) -> Int {
  return s.reduce(0) { (($0 + Int($1.asciiValue!)) * 17) % 256 }
}

func part2(_ lines: [String]) -> Int {
  var boxes: [[Lens]] = [[Lens]](repeating: [], count: 256)

  for line in lines {
    if let i = line.firstIndex(of: "=") {
      let label = String(line[..<i])
      let focalLength = Int(line[line.index(after: i)...])!

      let pos = hashAlg(label)
      switch boxes[pos].firstIndex(where: { $0.label == label } ) {
        case let .some(j):
          boxes[pos][j].focalLength = focalLength
        default:
          boxes[pos].append(Lens(label, focalLength))
      }
    } else {
      let label = String(line.dropLast())
      boxes[hashAlg(label)].retain { $0.label != label }
    }
  }

  return boxes.enumerated().reduce(0) {
    let (i, box) = $1
    return $0 + box.enumerated().reduce(0) {
      let (j, lens) = $1
      return $0 + i+ * j+ * lens.focalLength
    }
  }
}

let lines = readLine()!.split(separator: ",").map(String.init)

print("Part 1 answer:", lines.reduce(0) { $0 + hashAlg($1) })

print("Part 2 answer:", part2(lines))