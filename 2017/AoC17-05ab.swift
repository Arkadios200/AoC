func part1(_ input: [Int]) -> Int {
  var jumps = input

  var i = 0
  var count = 0
  while (0..<jumps.count).contains(i) {
    count += 1
    let dest = i + jumps[i]
    jumps[i] += 1
    i = dest
  }

  return count
}

func part2(_ input: [Int]) -> Int {
  var jumps = input

  var i = 0
  var count = 0
  while (0..<jumps.count).contains(i) {
    count += 1
    let dest = i + jumps[i]
    jumps[i] += jumps[i] < 3 ? 1 : -1
    i = dest
  }

  return count
}

var input = [Int]()
while let line = readLine() {
  input.append(Int(line)!)
}

print("Part 1 answer: \(part1(input))")
print("Part 2 answer: \(part2(input))")