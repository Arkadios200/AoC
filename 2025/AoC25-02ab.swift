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

    if l % 2 == 0, s.prefix(l/2) == s.suffix(l/2) {
      ans1 += n
      continue
    }

    loop: for i in 1...l/2 where l % i == 0 {
      let t = s.prefix(i)
      for j in stride(from: i, to: l, by: i) {
        if t != s[j..<j+i] {
          continue loop
        }
      }

      ans2 += n
      break
    }
  }
}

ans2 += ans1

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)