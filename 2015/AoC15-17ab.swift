func getInput() -> [Int] {
  var buckets: [Int] = []
  while let line = readLine() {
    buckets.append(Int(line)!)
  }

  return buckets
}

func calc(_ buckets: [Int], target: Int) -> [Int] {
  let bin = 1 << buckets.count

  var counts: [Int] = []
  outer: for i in 0..<bin {
    var n = i

    var count = 0
    var sum = 0
    for bucket in buckets {
      if sum > 150 { continue outer }
      let t = n % 2

      sum += bucket * t
      count += t
      n /= 2
    }

    if sum == target {
      counts.append(count)
    }
  }

  return counts
}

let buckets = getInput()

let counts = calc(buckets, target: 150)

let ans1 = counts.count
print("Part 1 answer: \(ans1)")

let min = counts.min()!
let ans2 = counts.filter { $0 == min }.count
print("Part 2 answer: \(ans2)")