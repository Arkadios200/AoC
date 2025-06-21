let input = readLine()!.split(separator: ",").map { Int($0)! }

let range = input.min()!...input.max()!

let ans1 = range.map {
  n in input.reduce(0) { $0 + abs($1 - n) }
}.min()!
print("Part 1 answer: \(ans1)")

let ans2 = range.map {
  n in input.reduce(0) {
    let d = abs($1 - n)
    return $0 + d * (d + 1) / 2
  }
}.min()!
print("Part 2 answer: \(ans2)")