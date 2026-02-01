import struct Foundation.URL

infix operator ><: MultiplicationPrecedence
infix operator ><=: AssignmentPrecedence

extension Int {
  func exp(_ power: Int) -> Int {
    var base = self
    for _ in 0..<power { base *= self }

    return base
  }

  static func >< (lhs: Int, rhs: Int) -> Int {
    return Int("\(lhs)\(rhs)")!
  }

  static func ><= (lhs: inout Int, rhs: Int) {
    lhs = lhs >< rhs
  }
}

func process(_ line: String) -> (Int, [Int]) {
  let nums = line.split {!$0.isNumber }.map { Int($0)! }
  return (nums.first!, Array(nums.dropFirst()))
}

func part1(_ lines: [(Int, [Int])]) -> Int {
  var out = 0
  for (total, nums) in lines {
    let ops = nums.count - 1
    for var n in 0..<2.exp(ops) {
      var temp = nums.first!
      for i in 1...ops {
        switch n % 2 {
          case 0: temp += nums[i]
          case 1: temp *= nums[i]
          default: fatalError()
        }

        if temp > total { break }

        n /= 2
      }

      if temp == total {
        out += total
        break
      }
    }
  }

  return out
}

func part2(_ lines: [(Int, [Int])]) -> Int {
  var out = 0
  for (total, nums) in lines {
    let ops = nums.count - 1
    for var n in 0..<3.exp(ops) {
      var temp = nums.first!
      for i in 1...ops {
        switch n % 3 {
          case 0: temp  += nums[i]
          case 1: temp  *= nums[i]
          case 2: temp ><= nums[i]
          default: fatalError()
        }
        
        if temp > total { break }

        n /= 3
      }

      if temp == total {
        out += total
        break
      }
    }
  }

  return out
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let lines: [(Int, [Int])] = input.split(separator: "\n").map { process(String($0)) }

print("Part 1 answer:", part1(lines))
print("Part 2 answer:", part2(lines))