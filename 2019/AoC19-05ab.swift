extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

func runProgram(_ _program: [Int], input: Int) {
  var program = _program
  var output: Int

  var i = 0
  execution: while i < program.count {
    var opcode = program[i]
    var parameterModes = [Int]()
    if opcode > 99 {
      let temp1 = Array(String(opcode))
      var temp2 = [String]()
      for x in temp1 {
        temp2.append(String(x))
      }
      opcode = Int(temp2[temp2.count-2...temp2.count-1].joined())!
      temp2.remove(at: temp2.count-1)
      temp2.remove(at: temp2.count-1)
      for j in temp2 {
        parameterModes.insert(Int(j)!, at: 0)
      }
    }
    let a = parameterModes[safe: 0] ?? 0 == 0 ? program[program[i+1]] : program[i+1]
    
    
    switch opcode {
      case 1:
        let b = parameterModes[safe: 1] ?? 0 == 0 ? program[program[i+2]] : program[i+2]
        program[program[i+3]] = a + b
        i += 4
        break
      case 2:
        let b = parameterModes[safe: 1] ?? 0 == 0 ? program[program[i+2]] : program[i+2]
        program[program[i+3]] = a * b
        i += 4
        break
      case 3:
        program[program[i+1]] = input
        i += 2
        break
      case 4:
        output = program[program[i+1]]
        print("Output: \(output)")
        i += 2
        break
      case 5:
        let b = parameterModes[safe: 1] ?? 0 == 0 ? program[program[i+2]] : program[i+2]
        if a != 0 {
          i = b
        } else {
          i += 3
        }
        break
      case 6:
        let b = parameterModes[safe: 1] ?? 0 == 0 ? program[program[i+2]] : program[i+2]
        if a == 0 {
          i = b
        } else {
          i += 3
        }
        break
      case 7:
        let b = parameterModes[safe: 1] ?? 0 == 0 ? program[program[i+2]] : program[i+2]
        program[program[i+3]] = a < b ? 1 : 0
        i += 4
        break
      case 8:
        let b = parameterModes[safe: 1] ?? 0 == 0 ? program[program[i+2]] : program[i+2]
        program[program[i+3]] = a == b ? 1 : 0
        i += 4
        break
      case 99:
        break execution
      default:
        print("Something broke")
        break execution
    }
  }
}

  

var program = [Int]()

for i in readLine()!.split(separator: ",") {
  program.append(Int(i)!)
}

runProgram(program, input: 1)
runProgram(program, input: 5)