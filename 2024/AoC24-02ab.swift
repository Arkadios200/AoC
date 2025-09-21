import struct Foundation.URL

func check(_ v: [Int]) -> Bool {
  var v = v
  if v.first! > v.last! { v.reverse() }

  return v.indices.dropFirst().allSatisfy { (1...3).contains(v[$0] - v[$0-1]) }
}

let input = try String(contentsOf: URL(fileURLWithPath: "input.txt"))

let reports: [[Int]] = input.split(separator: "\n").map { $0.split(separator: " ").map { Int($0)! } }

let notSafe = reports.filter { !check($0) }

let ans1 = reports.count - notSafe.count
let ans2 = ans1 + notSafe.filter {
  r in
  r.indices.contains {
    i in
    var v = r
    v.remove(at: i)
    return check(v)
  }
}.count

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)