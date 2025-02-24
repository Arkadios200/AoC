let input = Array(readLine()!).map( { Int(String($0))! } )

let count = input.count
let indices = input.indices

let total1 = indices
  .filter( { input[$0] == input[($0 + 1) % count] } )
  .reduce(0, { $0 + input[$1] } )

let total2 = 2 * indices[..<(count/2)]
  .filter( { input[$0] == input[$0 + count/2] } )
  .reduce(0, { $0 + input[$1] } )

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
