let stream = Array(readLine()!)

var total1 = 0
var total2 = 0
var score = 0
var garbage = false
var i = 0

while i < stream.count {
  if !garbage {
    switch stream[i] {
      case "{": score += 1
      case "}":
        total1 += score
        score -= 1
      case "<": garbage = true
      default: break
    }
  } else {
    switch stream[i] {
      case "!": i += 1
      case ">": garbage = false
      default: total2 += 1
    }
  }

  i += 1
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")