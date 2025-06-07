func getInput() -> [Int] {
  var nums: [Int] = []
  while let line = readLine() {
    nums.append(Int(line)!)
  }

  return nums
}

func part2(_ nums: [Int]) -> Int {
  var acc = 0
  var record: Set = [acc]

  while true {
    for n in nums {
      acc += n
      if !record.insert(acc).inserted { return acc }
    }
  }
}
    

let nums = getInput()

let ans1 = nums.reduce(0, +)
print("Part 1 answer: \(ans1)")

let ans2 = part2(nums)
print("Part 2 answer: \(ans2)")