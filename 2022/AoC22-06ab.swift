func indexAfterFirstNonrepeatingSubstring(ofLength length: Int, in line: [Character]) -> Int {
  let index = length - 1
  return 1 + line.indices[index...].first(where: {
    let temp = line[$0-index...$0]
    var counts = [Character: Int]()
    temp.forEach( { counts[$0] = (counts[$0] ?? 0) + 1 } )

    return counts.count == length
  } )!
}

let line = Array(readLine()!)

let total1 = indexAfterFirstNonrepeatingSubstring(ofLength: 4, in: line)

let total2 = indexAfterFirstNonrepeatingSubstring(ofLength: 14, in: line)

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
