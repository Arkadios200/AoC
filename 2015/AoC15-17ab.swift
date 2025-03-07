let target = 150

var buckets = [Int]()
while let line = readLine() {
  buckets.append(Int(line)!)
}

var total1 = 0
var counts = [Int]()
let bin = (1 << buckets.count)
for i in 0..<bin {
  let temp = Array(String(i, radix: 2).reversed())

  let b = buckets.indices.filter { ($0 < temp.count ? temp[$0] : "0") == "1" }
  let sum = b.reduce(0, { $0 + buckets[$1] } )

  if sum == target {
    total1 += 1
    counts.append(b.count)
  }
}

print("Part 1 answer: \(total1)")

let min = counts.min()!
let total2 = counts.filter { $0 == min }.count
print("Part 2 answer: \(total2)")
