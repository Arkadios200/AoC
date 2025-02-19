let input = readLine()!.split(separator: "-").map( { Int($0)! } )

let range = input.first!...input.last!

let part1 = range.map( { Array(String($0)).map( { Int(String($0))! } ) } ).filter( {
  let digits = $0
  return digits.indices[1...].allSatisfy( { digits[$0-1] <= digits[$0] } )
} ).filter( { Set($0).count < 6 } )

print("Part 1 answer: \(part1.count)")

let part2 = part1.filter( {
  var counts = [Int: Int]()
  $0.forEach( {
    counts[$0] = (counts[$0] ?? 0) + 1
  } )
  return counts.values.contains(2)
} )

print("Part 2 answer: \(part2.count)")
