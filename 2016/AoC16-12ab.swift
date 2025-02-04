var regs = [
  "a": 0,
  "b": 0,
  "c": 0,
  "d": 0
]

var instructions = [[String]]()
while let line = readLine() {
  instructions.append(line.split(separator: " ").map( { String($0) } ))
}

var i = 0
program: while i < instructions.count {
  let temp = instructions[i]
  switch temp[0] {
    case "cpy":
      if let t = Int(temp[1]) {
        regs[temp[2]] = t
      } else {
        regs[temp[2]] = regs[temp[1]]!
      }
    case "inc":
      regs[temp[1]] = regs[temp[1]]! + 1
    case "dec":
      regs[temp[1]] = regs[temp[1]]! - 1
    case "jnz":
      if let t = Int(temp[1]) {
        i += (t != 0) ? Int(temp[2])! : 1
      } else {
        i += (regs[temp[1]]! != 0) ? Int(temp[2])! : 1
      }
      continue program
    default:
      print("Something broke.")
      break program
  }
  i += 1
}

print("Program output: \(regs["a"]!)")
