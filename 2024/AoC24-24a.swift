import Foundation

var test = [String: Int]()
while let line = readLine() {
  if line == "" {break}
  let temp = line.components(separatedBy: ": ")
  test[temp[0]] = Int(temp[1])!
}

var gates = [String]()
while let line = readLine() {
  gates.append(line)
}

while gates.count > 0 {
  for i in stride(from:gates.count-1, through: 0, by: -1) {
    let g = gates[i].split(separator: " ").map( { String($0) } )
    if let x = test[g[0]], let y = test[g[2]] {
      switch g[1] {
        case "AND":
          test[g[4]] = (x == 1 && y == 1) ? 1 : 0
          break
        case "OR":
          test[g[4]] = (x == 1 || y == 1) ? 1 : 0
          break
        case "XOR":
          test[g[4]] = x ^ y
          break
        default:
          print("Something broke")
          break
      }

      gates.remove(at: i)
    }
  }
}

var final = [Character](repeating: "0", count: 50)
for (key, val) in test where key[key.startIndex] == "z" {
  final[Int(key[key.index(after: key.startIndex)..<key.endIndex])!] = Character(String(val))
}

let total1 = Int(String(final.reversed()), radix: 2)!)
print("Part 1 answer: \(total1)")