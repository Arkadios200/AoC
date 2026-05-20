extension Sequence where Element: Hashable {
  var contents: [Element: Int] {
    var contents: [Element: Int] = [:]
    self.forEach { contents[$0] = (contents[$0] ?? 0) + 1 }

    return contents
  }
}

extension Collection {
  func minByKey<K: Comparable>(_ key: (Element) -> K) -> Element? {
    return self.min { key($0) < key($1) }
  }

  func maxByKey<K: Comparable>(_ key: (Element) -> K) -> Element? {
    return self.max { key($0) < key($1) }
  }
}

func getInput() -> [[Character]] {
  var lines: [[Character]] = []
  while let line = readLine() {
    lines.append(Array(line))
  }

  return lines
}

let lines: [[Character]] = getInput()

var ans1 = ""
var ans2 = ""
for i in lines.first!.indices {
  let contents = lines.map { $0[i] }.contents

  ans1.append(contents.maxByKey { $0.value }!.key)
  ans2.append(contents.minByKey { $0.value }!.key)
}

print(ans1)
print(ans2)