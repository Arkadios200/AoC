struct Disc {
  let id: Int
  let slots: Int
  let start: Int

  func isAligned(at time: Int) -> Bool {
    return (time + start + id) % slots == 0
  }
}

func getInput() -> [Disc] {
  var discs: [Disc] = []
  while let line = readLine() {
    let temp = line.split { !$0.isNumber }.map { Int($0)! }
    discs.append(Disc(id: temp[0], slots: temp[1], start: temp[3]))
  }

  return discs
}

func calc(_ discs: [Disc]) -> Int {
  var time = 0
  while !discs.allSatisfy( { $0.isAligned(at: time) } ) {
    time += 1
  }

  return time
}

let discs: [Disc] = getInput()
let newDisc = Disc(id: discs.count + 1, slots: 11, start: 0)

print("Part 1 answer:", calc(discs))
print("Part 2 answer:", calc(discs + [newDisc]))