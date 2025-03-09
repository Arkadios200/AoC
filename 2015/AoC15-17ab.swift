let target = 150

var buckets = [Int]()
while let line = readLine() {
  buckets.append(Int(line)!)
}

var total1 = 0
var counts = [Int]()
let bin = (1 << buckets.count)
for i in 0..<bin {
  var temp = i

  var count = 0
  var sum = 0
  for bucket in buckets {
    if sum > 150 { break }
    let t = temp % 2

    sum += bucket * t
    count += t
    temp /= 2
  }

  if sum == target {
    total1 += 1
    counts.append(count)
  }
}

print("Part 1 answer: \(total1)")

let min = counts.min()!
let total2 = counts.filter { $0 == min }.count
print("Part 2 answer: \(total2)")