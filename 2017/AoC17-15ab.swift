func part1(a: Int, b: Int) -> Int {
  var a = a
  var b = b
  let n = (1 << 16) - 1

  var total = 0
  for _ in 1...40000000 {
    a = (a * 16807) % 2147483647
    b = (b * 48271) % 2147483647

    if (a & n) == (b & n) { total += 1 }
  }

  return total
}

func part2(a: Int, b: Int) -> Int {
  var a = a
  var b = b
  let n = (1 << 16) - 1

  var total = 0
  for _ in 1...5000000 {
    repeat { a = (a * 16807) % 2147483647 } while a % 4 != 0
    repeat { b = (b * 48271) % 2147483647 } while b % 8 != 0

    if (a & n) == (b & n) { total += 1 }
  }

  return total
}

let ans1 = part1(a: 65, b: 8921)
let ans2 = part2(a: 65, b: 8921)

print("Part 1 answer: \(ans1)")
print("Part 2 answer: \(ans2)")