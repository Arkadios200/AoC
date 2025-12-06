func getInput() -> [[Int]] {
  var banks: [[Int]] = []
  while let line = readLine() {
    banks.append(line.map { $0.wholeNumberValue! })
  }

  return banks
}

func calc(_ bank: [Int], length: Int) -> Int {
  guard length > 0 else { fatalError("Length must be greater than 0") }
  guard bank.count >= length else { fatalError("Bank must contain enough elements") }

  let bank = zip(1..., bank)

  var out = ""
  var offset = 0
  for i in 1...length {
    let (nextOffset, digit) = bank.dropFirst(offset).dropLast(length-i).max { $0.1 < $1.1 }!

    offset = nextOffset
    out += String(digit)
  }

  return Int(out)!
}

let banks = getInput()

let ans1 = banks.reduce(0) { $0 + calc($1, length: 2) }
let ans2 = banks.reduce(0) { $0 + calc($1, length: 12) }

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)