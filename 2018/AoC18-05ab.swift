func react(_ polymer: inout [Character]) -> Void {
  var i = 0
  while i < polymer.count-1 {
    if abs(Int(polymer[i].asciiValue!) - Int(polymer[i+1].asciiValue!)) == 32 {
      polymer.remove(at: i)
      polymer.remove(at: i)
    }
    i += 1
  }
}

let input = Array(readLine()!)
var copy = input

var x: Int
repeat {
  x = copy.count
  react(&copy)
} while x != copy.count

print("Part 1 answer: \(copy.count)")

var total = input.count
for i in 65...90 {
  copy = input
  var c = 0
  while c < copy.count {
    if copy[c] == Character(UnicodeScalar(i)!) || copy[c] == Character(UnicodeScalar(i+32)!) {
      copy.remove(at: c)
    } else {
      c += 1
    }
  }

  var x: Int
  repeat {
    x = copy.count
    react(&copy)
  } while x != copy.count

  if copy.count < total {
    total = copy.count
  }
}

print("Part 2 answer: \(total)")