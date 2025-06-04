enum IntcodeError: Error {
  case invalidOpcode(_ opcode: Int)
  case invalidInput(_ input: String)
  case syntaxError(_ input: String)
}

extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

func run(_ p: [Int]) throws {
  var p = p

  var i = 0
  loop: while i < program.count {      
    let temp = String(p[i])

    let opcode = Int(temp.suffix(2))!
    if opcode == 99 { break loop }

    let modes = Array(temp.dropLast(2).reversed())

    let opCount: Int = try {
      switch opcode {
        case 1, 2, 7, 8: return 3
        case 3, 4: return 1
        case 5, 6: return 2
        default: throw IntcodeError.invalidOpcode(opcode)
      }
    }()

    let params: [Int] = (0..<opCount).map {
      j in
      let c = modes[safe: j] ?? "0"
      return c == "0" ? p[i+j+1] : i+j+1
    }

    switch opcode {
      case 1: p[params[2]] = p[params[0]] + p[params[1]]
      case 2: p[params[2]] = p[params[0]] * p[params[1]]
      case 3: 
        let input = readLine()!
        if let n = Int(input) {
          p[params[0]] = n
        } else {
          throw IntcodeError.invalidInput(input)
        }
      case 4: print(p[params[0]])
      case 5:
        if p[params[0]] != 0 {
          i = p[params[1]]
          continue loop
        }
      case 6:
        if p[params[0]] == 0 {
          i = p[params[1]]
          continue loop
        }
      case 7: p[params[2]] = p[params[0]] < p[params[1]] ? 1 : 0
      case 8: p[params[2]] = p[params[0]] == p[params[1]] ? 1 : 0
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