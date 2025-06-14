func run(_ program: [Int], a: Int) -> [Int] {
  var regs = (a: a, b: 0, c: 0)

  let comboOp: (Int) -> Int = {
    n in
    switch n {
      case 0...3: return n
      case 4: return regs.a
      case 5: return regs.b
      case 6: return regs.c
      default: fatalError("Invalid input")
    }
  }

  var i = 0
  var output: [Int] = []
  while i < program.count {
    let op = program[i+1]

    switch program[i] {
      case 0: regs.a = regs.a >> comboOp(op)
      case 1: regs.b ^= op
      case 2: regs.b = comboOp(op) & 7
      case 3:
        if regs.a != 0 {
          i = op
          continue
        }
      case 4: regs.b ^= regs.c
      case 5: output.append(comboOp(op) & 7)
      case 6: regs.b = regs.a >> comboOp(op)
      case 7: regs.c = regs.a >> comboOp(op)
      default: fatalError("Invalid opcode")
    }

    i += 2
  }

  return output
}

let program = readLine()!.compactMap { Int(String($0)) }

print(run(program, a: 64584136).map(String.init).joined(separator: ","))