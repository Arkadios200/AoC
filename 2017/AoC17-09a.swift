var score = 0
let stream = Array(readLine()!)

var total1 = 0
var i = 0
var garbage = false
while i < stream.count {
  if !garbage {
    switch stream[i] {
      case "{":
        score += 1
        break
      case "}":
        total1 += score
        score -= 1
        break
      case "<":
        garbage = true
        break
      default:
        break
    }
  } else {
    switch stream[i] {
      case "!":
        i += 2
        continue
      case ">":
        garbage = false
        break
      default:
        break
    }
  }

  i += 1      
}

print("Part 1 answer: \(total1)")