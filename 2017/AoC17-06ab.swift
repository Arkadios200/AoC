func redistribute(_ banks: inout [Int]) -> Int {
  var record = [banks]

  while true {
    for (i, e) in banks.enumerated() where e == banks.max()! {
      var iter = i
      banks[i] = 0
      for _ in 1...e {
        iter = (iter + 1) % banks.count
        banks[iter] += 1
      }
      break
    }

    if record.contains(banks) {
      return record.count
    } else {
      record.append(banks)
    }
  }
}

var banks = readLine()!.split(separator: "\t").map( { Int($0)! } )

print("Part 1 answer: \(redistribute(&banks))")
print("Part 2 answer: \(redistribute(&banks))")