var elves = [Int]()
var elf = 0
while let line = readLine() {
  if line == "" {
    elves.append(temp)
    elf = 0
  } else {
    elf += Int(line)!
  }
}

elves.sort(by: >)

print("Part 1 answer: \(elves[0])")
print("Part 2 answer: \(elves[0...2].reduce(0, +))")
