func getInput() -> ([String: Bool], [[String]]) {
  var wires: [String: Bool] = [:]
  while let line = readLine() {
    if line.isEmpty { break }
    let label = String(line.prefix { $0 != ":" })
    wires[label] = (line.last! == "1")
  }

  var gates: [[String]] = []
  while let line = readLine() {
    gates.append(line.split(separator: " ").map { String($0) })
  }

  return (wires, gates)
}

func part1(_ wires: [String: Bool], _ gates: [[String]]) -> Int {
  var wires = wires

  var cond = true
  while cond {
    cond = false
    for gate in gates where wires[gate[4]] == nil {
      cond = true
      if let x = wires[gate[0]], let y = wires[gate[2]] {
        switch gate[1] {
          case "AND": wires[gate[4]] = x && y
          case "OR": wires[gate[4]] = x || y
          case "XOR": wires[gate[4]] = x != y
          default: break
        }
      }
    }
  }

  let n = wires
    .filter { $0.key.first! == "z" }
    .sorted { $0.key > $1.key }
    .map { $0.value ? "1" : "0" }
    .joined()

  return Int(n, radix: 2)!
}

let (wires, gates) = getInput()

let ans1 = part1(wires, gates)
print("Part 1 answer: \(ans1)")