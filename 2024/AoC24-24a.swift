struct Gate {
  let lhs: String
  let rhs: String
  let op:  String
  let out: String

  init(lhs: String, rhs: String, op: String, out: String) {
    self.lhs = lhs
    self.rhs = rhs
    self.op  = op
    self.out = out
  }

  static func from(_ line: String) -> Gate {
    let s = line.split(separator: " ").map { String($0) }

    return Gate(
      lhs: s[0],
      rhs: s[2],
      op:  s[1],
      out: s[4]
    )
  }

  func eval(_ wires: [String: Bool]) -> Bool? {
    guard let x = wires[lhs], let y = wires[rhs] else { return nil }

    return { switch op {
      case "AND": return x && y
      case "OR":  return x || y
      case "XOR": return x != y
      default: fatalError("Invalid operator")
    } }()
  }
}

func getInput() -> ([String: Bool], [Gate]) {
  var wires: [String: Bool] = [:]
  while let line = readLine() {
    if line.isEmpty { break }

    let label = String(line.prefix { $0 != ":" })
    wires[label] = (line.last! == "1")
  }

  var gates: [Gate] = []
  while let line = readLine() {
    gates.append(Gate.from(line))
  } 

  return (wires, gates)
}

func simulate(_ wires: [String: Bool], _ gates: [Gate]) -> Int {
  var wires = wires

  var cond = true
  while cond {
    cond = false
    for gate in gates where wires[gate.out] == nil {
      cond = true
      if let b = gate.eval(wires) { wires[gate.out] = b }
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

let ans1 = simulate(wires, gates)
print("Part 1 answer: \(ans1)")