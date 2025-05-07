enum IntcodeError: Error {
  case invalidOpcode(_ opcode: Int)
}

func run(_ p: [Int], _ p1: Int, _ p2: Int) throws -> Int {
  var p = p
  p[1] = p1
  p[2] = p2

  loop: for i in stride(from: 0, to: p.count, by: 4) {
    let opcode = p[i]
    let a = p[i+1]
    let b = p[i+2]
    let c = p[i+3]

    switch opcode {
      case 1: p[c] = p[a] + p[b]
      case 2: p[c] = p[a] * p[b]
      case 99: break loop
      default:
        throw IntcodeError.invalidOpcode(opcode)
    }
  }

  return p.first!
}

let program = readLine()!.split(separator: ",").map { Int($0)! }


let ans1 = try run(program, 12, 2)
print("Part 1 answer: \(ans1)")

outer: for noun in 0...99 {
  for verb in 0...99 {
    if try run(program, noun, verb) == 19690720 {
      print("Part 2 answer: \(noun * 100 + verb)")
      break outer
    }
  }
}