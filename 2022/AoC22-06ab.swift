func indexAfterFirstNonrepeatingSubstring(ofLength length: Int, in line: [Character]) -> Int {
  let index = length - 1
  return line.indices[index...].first(where: { Set(line[$0-index...$0]).count == length } )! + 1
}

let line = Array(readLine()!)

let total1 = indexAfterFirstNonrepeatingSubstring(ofLength: 4, in: line)

let total2 = indexAfterFirstNonrepeatingSubstring(ofLength: 14, in: line)

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")