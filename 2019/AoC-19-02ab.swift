func runProgram(_ input: [Int]) -> Int {
  var program = input
  
  for i in stride(from: 0, to: program.count, by: 4) {
    if program[i] == 1 {
      program[program[i+3]] = program[program[i+1]] + program[program[i+2]]
    } else if program[i] == 2 {
      program[program[i+3]] = program[program[i+1]] * program[program[i+2]]
    } else if program[i] == 99 {
      break
    } else {
      print("Something broke")
      break
    }
  }
  
  return program[0]
}
  

var program = [Int]()

for i in readLine()!.split(separator: ",") {
  program.append(Int(i)!)
}

program[1] = 12
program[2] = 2

let total1 = runProgram(program)
print("Part 1 answer: \(total1)")

let target = 19690720
var total2 = 0
outer: for noun in 0...99 {
  for verb in 0...99 {
    program[1] = noun
    program[2] = verb
    if runProgram(program) == target {
      total2 = 100 * noun + verb
      break outer
    }
  }
}

print("Part 2 answer: \(total2)")