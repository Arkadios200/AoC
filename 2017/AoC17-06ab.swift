func redistribute(_ banks: inout [Int]) -> Int {
  var record = Set<[Int]>()

  let len = banks.count
  while record.insert(banks).inserted {
    let (i, e) = banks.enumerated().max(by: { $0.element < $1.element } )!

    banks[i] = 0

    for x in 1...e {
      banks[(i + x) % len] += 1
    }
  }

  return record.count
}

var banks = readLine()!.split(separator: "\t").map( { Int($0)! } )

print("Part 1 answer: \(redistribute(&banks))")
print("Part 2 answer: \(redistribute(&banks))")