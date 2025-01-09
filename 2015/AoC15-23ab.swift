func runProgram(_ regs: [String: Int], _ instructions: [String]) -> Int {
  var regs = regs
  var i = 0
  while i < instructions.count {
    let temp = instructions[i].split(separator: " ")
    let s = String(temp[1])
    switch temp[0] {
      case "hlf":
        regs[s] = regs[s]! / 2
        i += 1
        break
      case "tpl":
        regs[s] = regs[s]! * 3
        i += 1
        break
      case "inc":
        regs[s] = regs[s]! + 1
        i += 1
        break
      case "jmp":
        i += Int(s)!
        break
      case "jie":
        if let r = regs[String(s[s.startIndex])] {
          if r % 2 == 0 {
            i += Int(temp[2])!
          } else {
            i += 1
          }
        }
        break
      case "jio":
        if let r = regs[String(s[s.startIndex])] {
          if r == 1 {
            i += Int(temp[2])!
          } else {
            i += 1
          }
        }
        break
      default:
        break
    }
  }

  return regs["b"]!
}

var instructions = [String]()
while let line = readLine() {
  instructions.append(line)
}

let total1 = runProgram(["a": 0, "b": 0], instructions)
print("Part 1 answer: \(total1)")

let total2 = runProgram(["a": 1, "b": 0], instructions)
print("Part 2 answer: \(total2)")
