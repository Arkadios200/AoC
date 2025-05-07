enum IntcodeError: Error {
  case invalidOpcode(_ opcode: Int)
  case invalidInput(_ input: String)
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
    let modes = Array(temp.dropLast(2).reversed())

    var opCount = 0
    switch opcode {
      case 1, 2, 7, 8: opCount = 3
      case 3, 4: opCount = 1
      case 5, 6: opCount = 2
      case 99: break loop
      default:
throw IntcodeError.invalidOpcode(opcode)
    }

    var params: [Int] = []
    for j in 0..<opCount {
      let c = modes[safe: j] ?? "0"
      params.append(c == "0" ? p[i+j+1] : i+j+1)
    }

    switch opcode {
      case 1: p[params[2]] = p[params[0]] + p[params[1]]
      case 2: p[params[2]] = p[params[0]] * p[params[1]]
      case 3: 
        let input = readLine()!
        if let n = Int(input) {
          p[params.last!] = n
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
      default: break loop
    }

    i += opCount + 1
  }
}

let program = readLine()!.split(separator: ",").map { Int($0)! }

try run(program)