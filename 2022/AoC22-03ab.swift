let priorities: [Character: Int] = [
  "a": 1,  "A": 27,
  "b": 2,  "B": 28,
  "c": 3,  "C": 29,
  "d": 4,  "D": 30,
  "e": 5,  "E": 31,
  "f": 6,  "F": 32,
  "g": 7,  "G": 33,
  "h": 8,  "H": 34,
  "i": 9,  "I": 35,
  "j": 10, "J": 36,
  "k": 11, "K": 37,
  "l": 12, "L": 38,
  "m": 13, "M": 39,
  "n": 14, "N": 40,
  "o": 15, "O": 41,
  "p": 16, "P": 42,
  "q": 17, "Q": 43,
  "r": 18, "R": 44,
  "s": 19, "S": 45,
  "t": 20, "T": 46,
  "u": 21, "U": 47,
  "v": 22, "V": 48,
  "w": 23, "W": 49,
  "x": 24, "X": 50,
  "y": 25, "Y": 51,
  "z": 26, "Z": 52
]

var rucksacks = [[Character]]()
while let line = readLine() {
  rucksacks.append(Array(line))
}

var total1 = 0, total2 = 0
for (i, rucksack) in rucksacks.enumerated() {
  let temp = [rucksack[0..<rucksack.count/2], rucksack[rucksack.count/2..<rucksack.count]]
  total1 += priorities.first(where: {
    let key = $0.key 
    return temp.allSatisfy( { $0.contains(key) } )
  } )?.value ?? 0

  if i % 3 == 0 {
    total2 += priorities.first(where: {
      let key = $0.key
      return rucksacks[i...i+2].allSatisfy( { $0.contains(key) } )
    } )?.value ?? 0
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
