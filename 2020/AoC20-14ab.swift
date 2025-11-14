func getInput() -> [String] {
  var input: [String] = []
  while let line = readLine() { input.append(line) }

  return input
}

func part1(_ input: [String]) -> Int {
  var mem: [Int: Int] = [:]
  var mask: [Character] = []
  for line in input {
    let temp = line.split { !($0.isNumber || $0.isLetter) }

    switch temp.first! {
      case "mask":
        mask = Array(temp.last!)
      case "mem":
        let i = Int(temp[1])!
        let n = Int(temp.last!)!

        var s = Array(String(n, radix: 2))
        s = Array(repeating: "0", count: 36 - s.count) + s
        for i in s.indices {
          if mask[i] == "X" { continue }
          s[i] = mask[i]
        }

        mem[i] = Int(String(s), radix: 2)!
      default: fatalError()
    }
  }

  return mem.values.reduce(0, +)
}

func part2(_ input: [String]) -> Int {
  var mem: [Int: Int] = [:]
  var mask: [Character] = []

  for line in input {
    let temp = line.split { !($0.isNumber || $0.isLetter) }

    switch temp.first! {
      case "mask":
        mask = Array(temp.last!)
      case "mem":
        var index = Array(String(Int(temp[1])!, radix: 2))
        index = Array(repeating: "0", count: 36 - index.count) + index
        for i in mask.indices where mask[i] == "1" { index[i] = "1" }

        let n = Int(temp.last!)!

        let xs = mask.indices.filter { mask[$0] == "X" }
        for y in 0..<(1 << xs.count) {
          var z = Array(String(y, radix: 2))
          z = Array(repeating: "0", count: xs.count - z.count) + z

          for (a, b) in zip(xs, z) { index[a] = b }

          mem[Int(String(index), radix: 2)!] = n
        }
      default: fatalError()
    }
  }

  return mem.values.reduce(0, +)
}

let input = getInput()

print("Part 1 answer:", part1(input))
print("Part 2 answer:", part2(input))