func getInput() -> [(String, String)] {
  var pairs: [(String, String)] = []
  while let line = readLine(), !line.isEmpty {
    let temp = line.split(separator: "-", maxSplits: 1).map(String.init)

    pairs.append((temp[0], temp[1]))
  }

  return pairs
}

let pairs = getInput()

var triples: Set<[String]> = []
for (a, b) in pairs {
  var tempA: Set<String> = []
  var tempB: Set<String> = []
  for (c, d) in pairs {
    if c == a && d != b {
      tempA.insert(d)
    } else if d == a && c != b {
      tempA.insert(c)
    } else if c == b && d != a {
      tempB.insert(d)
    } else if d == b && c != a {
      tempB.insert(c)
    }
  }

  triples.formUnion(tempA.intersection(tempB).map { [a, b, $0].sorted() })
}

let ans1 = triples.filter { $0.contains { $0.first! == "t" } }.count

print("Part 1 answer:", ans1)