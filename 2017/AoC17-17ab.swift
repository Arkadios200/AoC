let input = 377

var arr = [0]
var index = 0
for i in 1...2017 {
  index = ((index + input) % i) + 1
  arr.insert(i, at: index)
}
let ans1 = arr[arr.firstIndex(of: 2017)! + 1]
print("Part 1 answer: \(ans1)")

index = 0
var ans2 = 0
for i in 1...50000000 {
  index = ((index + input) % i) + 1
  if index == 1 { ans2 = i }
}
print("Part 2 answer: \(ans2)")
