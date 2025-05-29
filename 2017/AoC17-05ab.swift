func getInput() -> [Int] {
  var nums: [Int] = []
  while let line = readLine() {
    nums.append(Int(line)!)
  }

  return nums
}

func navigate(_ nums: [Int], with closure: (inout Int) -> Void) -> Int {
  var nums = nums

  var i = 0
  var loopCount = 0
  while nums.indices.contains(i) {
    loopCount += 1

    let dest = i + nums[i]
    closure(&nums[i])
    i = dest
  }

  return loopCount
}

let nums = getInput()

let ans1 = navigate(nums) { $0 += 1 }
print("Part 1 answer: \(ans1)")

let ans2 = navigate(nums) { $0 += ($0 < 3 ? 1 : -1) }
print("Part 2 answer: \(ans2)")