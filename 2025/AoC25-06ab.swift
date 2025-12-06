func transpose<T>(of arr: [[T]]) -> [[T]]? {
  guard Set(arr.map( { $0.count } )).count == 1 else { return nil }

  return arr.first?.indices.map { j in arr.map { $0[j] } }
}

func getInput() -> [([Int], [Int], Character)] {
  var lines: [String] = []
  while let line = readLine() { lines.append(line) }

  let nums1: [[Int]] = transpose(of: lines.dropLast().map { $0.split(separator: " ").map { Int($0)! } })!

  let nums2: [[Int]] = transpose(of: lines.dropLast().map { Array($0) })!
    .split { Set($0) == [" "] }
    .map {
      $0.map { Int(String($0.filter { $0.isNumber }))! }
    }

  let signs = lines.last!.split(separator: " ").map { Character(String($0)) }

  guard nums1.count == nums2.count else { fatalError() }
  guard nums1.count == signs.count else { fatalError() }

  let problems: [([Int], [Int], Character)] = signs.indices.map { (nums1[$0], nums2[$0], signs[$0]) }

  return problems
}

let problems: [([Int], [Int], Character)] = getInput()

let (ans1, ans2) = problems.reduce((0, 0)) {
  let (nums1, nums2, sign) = $1
  let (acc, op): (Int, (Int, Int) -> Int) = {
    switch sign {
      case "+": return (0, +)
      case "*": return (1, *)
      default: fatalError()
    }
  }()

  return ($0.0 + nums1.reduce(acc, op), $0.1 + nums2.reduce(acc, op))
}

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)