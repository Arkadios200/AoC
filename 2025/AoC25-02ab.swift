import struct Foundation.URL

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let ranges: [ClosedRange<Int>] = input.split(separator: ",").map {
  let temp = $0.split(separator: "-", maxSplits: 1).map { Int($0)! }

  return temp[0]...temp[1]
}

var ans1 = 0
var ans2 = 0
for r in ranges {
  for n in r where n >= 10 {
    let s = Array(String(n))
    let l = s.count

    if l % 2 == 0, s.prefix(l/2) == s.suffix(l/2) { ans1 += n }

    for i in 1...l/2 where l % i == 0 {
      let t = Array(s.prefix(i))
      if Array([[Character]](repeating: t, count: l/i).joined()) == s {
        ans2 += n
        break
      }
    }
  }
}

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)