enum IntcodeError: Error {
  case invalidOpcode(_ opcode: Int)
  case invalidInput(_ input: String)
  case syntaxError(_ input: String)
}

func run(_ program: [Int]) throws {
  var program = program

  var i = 0
  loop: while i < program.count {      
    var temp = program[i]

    let opcode = temp % 100
    if opcode == 99 { break loop }
    temp /= 100

    let opCount: Int = try {
      () throws -> Int in
      switch opcode {
        case 1, 2, 7, 8: return 3
        case 3, 4: return 1
        case 5, 6: return 2
        default: throw IntcodeError.invalidOpcode(opcode)
      }
    }()

    var args: [Int] = []
    for j in 0..<opCount {
      args.append(try {
        switch temp % 10 {
          case 0: return program[i+j+1]
          case 1: return i+j+1
          default: throw IntcodeError.invalidOpcode(opcode)
        }
      }())

      temp /= 10
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