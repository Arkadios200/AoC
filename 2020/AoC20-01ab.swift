var nums = [Int]()
while let line = readLine() {
  nums.append(Int(line)!)
}

part1: for i in 0..<nums.count-1 {
  for j in i+1..<nums.count {
    if nums[i] + nums[j] == 2020 {
      let total1 = nums[i] * nums[j]
      print("Part 1 answer: \(total1)")
      break part1
    }
  }
}

part2: for i in 0..<nums.count-2 {
  for j in i+1..<nums.count-1 {
    for k in j+1..<nums.count {
      if nums[i] + nums[j] + nums[k] == 2020 {
        let total2 = nums[i] * nums[j] * nums[k]
        print("Part 2 answer: \(total2)")
        break part2
      }
    }
  }
}
