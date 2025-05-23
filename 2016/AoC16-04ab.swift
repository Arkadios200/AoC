extension Sequence where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0] = (contents[$0] ?? 0) + 1 }

    return contents
  }
}

func getInput() -> [(name: String, id: Int, letters: [Character])] {
  var lines: [(String, Int, [Character])] = []
  while let line = readLine() {
    let temp = line.split { !($0.isLetter || $0.isNumber) }

    let name = temp.dropLast(2).joined(separator: "-")
    let id = Int(temp[temp.index(before: temp.indices.last!)])!
    let letters = Array(temp.last!)

    lines.append((name, id, letters))
  }

  return lines
}

func check(_ line: (String, Int, [Character])) -> Bool {
  let letters = line.0.filter { $0 != "-" }.contents
    .sorted(by: { $0.value != $1.value ? $0.value > $1.value : $0.key < $1.key } )
    .prefix(5).map { $0.key }

  return letters == line.2
}

func decrypt(_ line: (String, Int, [Character])) -> (id: Int, name: String) {
  let letters = Array("abcdefghijklmnopqrstuvwxyz")

  let id = line.1
  let name = String(line.0.map {
    if let i = letters.firstIndex(of: $0) {
      return letters[(i + id) % 26]
    } else {
      return " "
    }
  })

  return (id, name)
}

let input = getInput()

let filteredInput = input.filter(check)

let ans1 = filteredInput.reduce(0) { $0 + $1.id }
print("Part 1 answer: \(ans1)")

let decryptedRooms = filteredInput.map(decrypt)

let ans2 = decryptedRooms.first { $0.name == "northpole object storage" }!.id
print("Part 2 answer: \(ans2)")