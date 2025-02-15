func += (a: inout (Int, Int), b: (Int, Int)) {
  a.0 += b.0
  a.1 += b.1
}

func val(of line: [Int]) -> (Int, Int) {
  let val1 = line[0] * line[1] + line.indices.reduce(0, { $0 + 2 * line[$1] * line[($1 + 1) % 3] } )

  let val2 = 2*(line[0] + line[1]) + line.reduce(1, *)

  return (val1, val2)
}

var total = (0, 0)
while let line = readLine() {
  total += val(of: line.split(separator: "x").map( { Int($0)! } ).sorted())
}

let (total1, total2) = total
print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
