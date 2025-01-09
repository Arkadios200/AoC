var regs: [String: Int] = ["a": 0, "b": 0]
var instructions = [String]()

while let line = readLine() {
  instructions.append(line)
}

var i = 0
while i < ins.count {
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

print(regs)
