let stream = Array(readLine()!)

var total1 = 0
var total2 = 0
var score = 0
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
        total2 += 1
        break
    }
  }

  i += 1      
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
