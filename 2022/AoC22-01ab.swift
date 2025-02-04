var elves = [Int]()
var temp = 0
while let line = readLine() {
  if line == "" {
    elves.append(temp)
    temp = 0
  } else {
    temp += Int(line)!
  }
}

elves.sort(by: >)
print("Part 1 answer: \(elves[0])")

let total2 = elves[0...2].reduce(0, +)
print("Part 2 answer: \(total2)")
