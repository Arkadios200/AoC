let length = 272

func curve(_ s: [Character]) -> [Character] {
  let out = s + ["0"] + s.reversed().map { $0 == "0" ? "1" : "0" }

  if out.count < length {
    return curve(out)
  } else {
    return Array(out.prefix(length))
  }
}

func checksum(_ arr: [Character]) -> String {
  let out: [Character] = arr.indices.filter { $0 % 2 == 0 }.map { arr[$0] == arr[$0+1] ? "1" : "0" }

  if out.count % 2 == 0 {
    return checksum(out)
  } else {
    return String(out)
  }
}

let input = Array(readLine()!)

let ans1 = checksum(curve(input))
print("Part 1 answer: \(ans1)")