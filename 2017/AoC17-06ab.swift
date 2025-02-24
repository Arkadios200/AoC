func redistribute(_ banks: inout [Int]) -> Int {
  var record: Set<[Int]> = [banks]

  while true {
    let len = record.count
    let (i, e) = banks.enumerated().max(by: { $0.element < $1.element } )!

    var iter = i
    banks[iter] = 0
    for _ in 1...e {
      iter = (iter + 1) % banks.count
      banks[iter] += 1
    }

    record.insert(banks)

    if record.count == len {
      return record.count
    }
  }
}

var banks = readLine()!.split(separator: "\t").map( { Int($0)! } )

print("Part 1 answer: \(redistribute(&banks))")
print("Part 2 answer: \(redistribute(&banks))")