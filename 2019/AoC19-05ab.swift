enum IntcodeError: Error {
  case invalidOpcode(_ opcode: Int)
  case invalidInput(_ input: String)
  case syntaxError(_ input: String)
}

extension Collection {
  func get(at index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

func run(_ program: [Int]) throws {
  var program = program

  var i = 0
  loop: while i < program.count {      
    let temp = String(program[i])

    let opcode = Int(temp.suffix(2))!
    if opcode == 99 { break loop }

    let modes = Array(temp.dropLast(2).reversed())

    let opCount: Int = try {
      () throws -> Int in
      switch opcode {
        case 1, 2, 7, 8: return 3
        case 3, 4: return 1
        case 5, 6: return 2
        default: throw IntcodeError.invalidOpcode(opcode)
      }
    }()

    let args: [Int] = (0..<opCount).map {
      (j) -> Int in
      let c = modes.get(at: j) ?? "0"
      return c == "0" ? program[i+j+1] : i+j+1
    }

    switch opcode {
      case 1: program[args[2]] = program[args[0]] + program[args[1]]
      case 2: program[args[2]] = program[args[0]] * program[args[1]]
      case 3: 
        let input = readLine()!
        if let n = Int(input) {
          program[args[0]] = n
        } else {
          throw IntcodeError.invalidInput(input)
        }
      case 4: print(program[args[0]])
      case 5:
        if program[args[0]] != 0 {
          i = program[args[1]]
          continue loop
        }
      case 6:
        if program[args[0]] == 0 {
          i = program[args[1]]
          continue loop
        }
      case 7: program[args[2]] = program[args[0]] < program[args[1]] ? 1 : 0
      case 8: program[args[2]] = program[args[0]] == program[args[1]] ? 1 : 0
      default: throw IntcodeError.invalidOpcode(opcode)
    }

    i += opCount + 1
  }
}

let program: [Int] = try readLine()!.split(separator: ",").map {
  let s = String($0)
  if let i = Int(s) {
    return i
  } else {
    throw IntcodeError.syntaxError(s)
  }
}

try run(program)