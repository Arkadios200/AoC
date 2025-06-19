func dance(_ chars: inout [Character], _ input: [String]) {
  for line in input {
    switch line.first! {
      case "s":
        let n = Int(line.dropFirst())!
        chars = chars.suffix(n) + chars.dropLast(n)
      case "x":
        let nums = line.split { !$0.isNumber }.map { Int($0)! }
        chars.swapAt(nums[0], nums[1])
      case "p":
        let temp = line.dropFirst()
        let a = chars.firstIndex(of: temp.first!)!
        let b = chars.firstIndex(of: temp.last!)!

        chars.swapAt(a, b)
      default: fatalError("Invalid instruction: \(line)")
    }
  }
}

func populate(_ chars: [Character], _ input: [String]) -> [Int: String] {
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

let input = readLine()!.split(separator: ",").map { String($0) }
var chars = Array("abcdefghijklmnop")

let changes: [Int: String] = populate(chars, input)

let ans1 = changes[1]!
print("Part 1 answer: \(ans1)")

let ans2 = changes[1000000000 % changes.count]!
print("Part 2 answer: \(ans2)")