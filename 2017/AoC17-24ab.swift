struct Component {
  var ports: (Int, Int)
  let id: Int

  init(_ p1: Int, _ p2: Int, _ id: Int) {
    self.ports = (p1, p2)
    self.id = id
  }

  mutating func rev() -> Void {
    ports = (ports.1, ports.0)
  }
}

func getMaxStrength(of bridges: [[Component]]) -> Int {
  var maxStrength = 0
  for b in bridges {
    var temp = 0
    for c in b {
      temp += c.ports.0 + c.ports.1
    }
    if temp > maxStrength {
      maxStrength = temp
    }
  }

  return maxStrength
}

var components = [Component]()
var newID = 0
while let line = readLine() {
  let temp = line.split(separator: "/").map( { Int($0)! } )
  components.append(Component(temp[0], temp[1], newID))
  newID += 1
}

var bridges = [[Component]]()
for c in components {
  var c = c
  if c.ports.0 == 0 {
    bridges.append([c])
  } else if c.ports.1 == 0 {
    c.rev()
    bridges.append([c])
  }
}

var currentLength = bridges.last!.count
var bridgesCount = 0
while bridgesCount != bridges.count {
  bridgesCount = bridges.count
  for bridge in bridges where bridge.count == currentLength {
    for c in components where !bridge.contains(where: { $0.id == c.id } ) {
      var c = c
      
      if c.ports.0 == bridge.last!.ports.1 {
        var newBridge = bridge
        newBridge.append(c)
        bridges.append(newBridge)
      } else if c.ports.1 == bridge.last!.ports.1 {
        c.rev()
        var newBridge = bridge
        newBridge.append(c)
        bridges.append(newBridge)
      }
    }
  }

  currentLength = bridges.last!.count
}

let total1 = getMaxStrength(of: bridges)
print("Part 1 answer: \(total1)")

var length = 0
for b in bridges where b.count > length {
  length = b.count
}

var longestBridges = [[Component]]()
for b in bridges where b.count == length {
  longestBridges.append(b)
}


let total2 = getMaxStrength(of: longestBridges)
print("Part 2 answer: \(total2)")
