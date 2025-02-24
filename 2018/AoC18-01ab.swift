var input = [Int]()
while let line = readLine() {
  input.append(Int(line)!)
}

var record: Set<Int> = []

var found1 = false
var found2 = false
var prev = 0
while !(found1 && found2) {
  for i in input {
    let freq = prev + i

    if !record.insert(freq).inserted && !found2 {
      print("Part 2 answer: \(freq)")
      found2 = true
    } else {
      prev = freq
    }
  }

  if !found1 {
    print("Part 1 answer: \(prev)")
    found1 = true
  }
}
