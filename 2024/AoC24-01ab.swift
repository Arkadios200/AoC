func + (a: (Int, Int), b: (Int, Int)) -> (Int, Int) {
  return (a.0 + b.0, a.1 + b.1)
}

var lists: ([Int], [Int]) = ([], [])
while let line = readLine() {
  let temp = line.split(separator: " ").map( { Int($0)! } )
  lists.0.append(temp[0])
  lists.1.append(temp[1])
}

lists.0.sort()
lists.1.sort()

let (total1, total2) = lists.0.indices.reduce((0, 0), {
  let (a, b) = (lists.0[$1], lists.1[$1])
  return $0 + (abs(a - b), a * lists.1.filter( { $0 == a } ).count)
} )

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
