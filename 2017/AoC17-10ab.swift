func part1(_ input: String) -> Int {
  let dirs = input.split(separator: ",").map { Int($0)! }

  var nums = [Int](repeating: 0, count: 256).indices.map { Int($0) }
  let count = nums.count

  var skip = 0
  var i = 0
  for n in dirs {
    let range = Array((i..<i+n).map { $0 % count })
    for (j, e) in zip(range, range.map( { nums[$0] } ).reversed()) {
      nums[j] = e
    }

    i = (i + n + skip) % count
    skip += 1
  }

  return nums[0] * nums[1]
}

func knotHash(_ input: String) -> String {
  let dirs = input.map { Int($0.asciiValue!) } + [17, 31, 73, 47, 23]

  var nums = Array(0..<256)
  let count = nums.count

  var skip = 0
  var i = 0
  for _ in 1...64 {
    for n in dirs {
      let range = Array((i..<i+n).map { $0 % count })
      for (j, e) in zip(range, range.map( { nums[$0] } ).reversed()) {
        nums[j] = e
    }

      i = (i + n + skip) % count
      skip += 1
    }
  }

  let dense = nums.indices.compactMap {
    $0 % 16 == 0 ? String(nums[$0..<$0+16].reduce(0, ^), radix: 16) : nil
  }.map { $0.count == 1 ? "0\($0)" : $0 }.joined()

  return dense
}

let input = readLine()!

let ans1 = part1(input)
print("Part 1 answer: \(ans1)")

let ans2 = knotHash(input)
print("Part 2 answer: \(ans2)")
