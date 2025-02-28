struct Aunt {
  let num: Int
  let data: [(String, Int)]

  init(_ num: Int, _ data: [(String, Int)]) {
    self.num = num
    self.data = data
  }
}

func process(_ line: String) -> (Int, [(String, Int)]) {
  let temp = line.filter( { $0 != " " } ).split(separator: ":", maxSplits: 1)

  let num = Int(temp[0].filter( { $0.isNumber } ))!
  let data = temp[1].split(separator: ",")
    .map( { $0.split(separator: ":") } )
    .map( { (String($0[0]), Int($0[1])!) } )

  return (num, data)
}

let targetAunt1: [String: Int] = [
  "children":    3,
  "cats":        7,
  "samoyeds":    2,
  "pomeranians": 3,
  "akitas":      0,
  "vizslas":     0,
  "goldfish":    5,
  "trees":       3,
  "cars":        2,
  "perfumes":    1
]

let targetAunt2: [String: (Int) -> Bool] = [
  "children":    { $0 == 3 },
  "cats":        { $0 > 7 },
  "samoyeds":    { $0 == 2 },
  "pomeranians": { $0 < 3 },
  "akitas":      { $0 == 0 },
  "vizslas":     { $0 == 0 },
  "goldfish":    { $0 < 5 },
  "trees":       { $0 > 3 },
  "cars":        { $0 == 2 },
  "perfumes":    { $0 == 1 }
]

var aunts = [Aunt]()
while let line = readLine() {
  let (num, data) = process(line)
  aunts.append(Aunt(num, data))
}

let ans1 = aunts.first(where: {
  $0.data.allSatisfy( { targetAunt1[$0.0]! == $0.1 } )
} )!.num

let ans2 = aunts.first(where: {
  $0.data.allSatisfy( { targetAunt2[$0.0]!($0.1) } )
} )!.num

print("Part 1 answer: \(ans1)")
print("Part 2 answer: \(ans2)")