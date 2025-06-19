func dance(_ chars: inout [Character], _ input: [(Character, String)]) {
  for line in input {
    switch line.0 {
      case "s":
        let n = Int(line.1)!
        chars = chars.suffix(n) + chars.dropLast(n)
      case "x":
        let nums = line.1.split(separator: "/", maxSplits: 1).map { Int($0)! }
        chars.swapAt(nums[0], nums[1])
      case "p":
        let a = chars.firstIndex(of: line.1.first!)!
        let b = chars.firstIndex(of: line.1.last!)!

        chars.swapAt(a, b)
      default: fatalError("Invalid instruction: \(line)")
    }
  }
}

func populate(_ chars: [Character], _ input: [(Character, String)]) -> [Int: String] {
  var chars = chars

  var record: Set<[Character]> = []
  var changes: [Int: String] = [:]

  var i = 0
  while record.insert(chars).inserted {
    changes[i] = String(chars)
    i += 1
    dance(&chars, input)
  }

  return changes
}

let input = readLine()!.split(separator: ",").map { ($0.first!, String($0.dropFirst())) }
let chars = Array("abcdefghijklmnop")

let changes: [Int: String] = populate(chars, input)

let ans1 = changes[1]!
print("Part 1 answer: \(ans1)")

let ans2 = changes[1000000000 % changes.count]!
print("Part 2 answer: \(ans2)")