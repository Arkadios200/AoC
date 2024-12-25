var banks = readLine()!.split(separator: "\t").map( { Int($0)! } )

var record = [[Int]]()
record.append(banks)

var check = false
while true {
  for i in 0..<banks.count where banks[i] == banks.max()! {
    var iter = i
    var val = banks[i]
    banks[i] = 0
    while val > 0 {
      iter = (iter + 1) % banks.count
      banks[iter] += 1
      val -= 1
    }
    break
  }

  if !record.contains(where: { $0 == banks }) {
    record.append(banks)
  } else {
    if check == true {break}
    print("Part 1 answer: \(record.count)")
    record.removeAll()
    record.append(banks)
    check = true
  }
}

print("Part 2 answer: \(record.count)")