import Foundation

func exp(_ a: Int, _ b: Int) -> Int {
  if b == 0 {return 1}

  var x = 1
  for _ in 1...b {
    x *= a
  }

  return x  
}

func getComboOp (_ literal: Int, _ regs: [Character: Int]) -> Int {
  switch literal {
    case 0...3:
      return literal
    case 4:
      return regs["a"]!
    case 5:
      return regs["b"]!
    case 6:
      return regs["c"]!
    default:
      print("Something broke")
      return -1
  }
}

func runProgram(_ program: [Int], a: Int) -> String {
  var regs: [Character: Int] = ["a": a, "b": 0, "c": 0]

  var output = ""
  var i = 0
  while i < program.count {
    let op = program[i+1]
    switch program[i] {
      case 0:
        regs["a"] = regs["a"]! / exp(2, getComboOp(op, regs))
        i += 2
        break
      case 1:
        regs["b"] = regs["b"]! ^ op
        i += 2
        break
      case 2:
        regs["b"] = getComboOp(op, regs) % 8
        i += 2
        break
      case 3:
        i = regs["a"] != 0 ? op : i + 2
        break
      case 4:
        regs["b"] = regs["b"]! ^ regs["c"]!
        i += 2
        break
      case 5:
        output.append("\(String(getComboOp(op, regs) % 8)),")
        i += 2
        break
      case 6:
        regs["b"] = regs["a"]! / exp(2, getComboOp(op, regs))
        i += 2
        break
      case 7:
        regs["c"] = regs["a"]! / exp(2, getComboOp(op, regs))
        i += 2
        break
      default:
        print("Something broke")
        break
    }
  }
  
  output.remove(at: output.index(before: output.endIndex))

  return output
}

let temp = "0,1,5,4,3,0"

var input = [Int]()
for t in temp.split(separator: ",") {
  input.append(Int(t)!)
}

let total1 = runProgram(input, a: 729)
print("Part 1 answer: \(total1)")