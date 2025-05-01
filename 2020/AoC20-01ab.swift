func getInput() -> [Int] {
  var input: [Int] = []
  while let line = readLine() {
    input.append(Int(line)!)
  }

  return input
}

func findTwoInts(in nums: [Int], thatSumTo target: Int) -> Int? {
  var a = nums.indices.first!
  var b = nums.indices.last!

  while true {
    if a >= b {
      return nil
    } else if nums[a] + nums[b] < target {
      a += 1
    } else if nums[a] + nums[b] > target {
      b -= 1
    } else {
      break
    }
  }

  return nums[a] * nums[b]
}

let nums = getInput().sorted()

let ans1 = findTwoInts(in: nums, thatSumTo: 2020)!
print("Part 1 answer: \(ans1)")

let ans2 = nums.map {
  n in n * (findTwoInts(in: nums, thatSumTo: 2020 - n) ?? 0)
}.first { $0 != 0 }!
print("Part 2 answer: \(ans2)")