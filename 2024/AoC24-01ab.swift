var lists: ([Int], [Int]) = ([], [])
while let line = readLine() {
  let temp = line.split(separator: " ").map( { Int($0)! } )
  lists.0.append(temp[0])
  lists.1.append(temp[1])
}

lists.0.sort()
lists.1.sort()

var total1 = 0
var total2 = 0
for i in 0..<lists.0.count {
  total1 += abs(lists.1[i] - lists.0[i])

  var count = 0
  for j in lists.1 where lists.0[i] == j {
    count += 1
  }
  total2 += lists.0[i] * count
}
print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
