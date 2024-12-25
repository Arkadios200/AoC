var jumps = [Int]()
while let x = readLine() {
  jumps.append(Int(x)!)
}

let jumpsCopy = jumps

var i = 0
var jumpCount = 0
while i < jumps.count && i >= 0 {
  jumps[i] += 1
  i += jumps[i] - 1
  jumpCount += 1
}

print("Part 1 answer: \(jumpCount)")

jumps = jumpsCopy
i = 0
jumpCount = 0
while i < jumps.count && i >= 0 {
  let diff = (jumps[i] < 3 ? 1 : -1)
  jumps[i] += diff
  i += jumps[i] - diff
  jumpCount += 1
}

print("Part 2 answer: \(jumpCount)")