enum Part {
  case one
  case two
}

func navigate(_ input: [Int], _ part: Part) -> Int {
  var jumps = input

  var i = 0
  var count = 0
  while (0..<jumps.count).contains(i) {
    count += 1
    let dest = i + jumps[i]
    switch part {
      case .one:
        jumps[i] += 1
      case .two:
        jumps[i] += jumps[i] < 3 ? 1 : -1
    }
    i = dest
  }

  return count
}

var input = [Int]()
while let line = readLine() {
  input.append(Int(line)!)
}

print("Part 1 answer: \(navigate(input, Part.one))")
print("Part 2 answer: \(navigate(input, Part.two))")