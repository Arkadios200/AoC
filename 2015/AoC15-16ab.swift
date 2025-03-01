struct Aunt {
  let num: Int
  let data: [(String, Int)]

  init(_ num: Int, _ data: [(String, Int)]) {
    self.num = num
    self.data = data
  }

  static func process(_ line: String) -> Aunt {
    let temp = line.filter( { $0 != " " } ).split(separator: ":", maxSplits: 1)

    let num: Int = Int(temp[0].filter( { $0.isNumber } ))!

    let data: [(String, Int)] = temp[1].split(separator: ",")
      .map( {
        let s = $0.split(separator: ":")
        return (String(s[0]), Int(s[1])!)
      } )

    return Aunt(num, data)
  }
}

let targetData: [String: (Int, (Int) -> Bool)] = [
  "children":    (3, { $0 == 3 } ),
  "cats":        (7, { $0  > 7 } ),
  "samoyeds":    (2, { $0 == 2 } ),
  "pomeranians": (3, { $0  < 3 } ),
  "akitas":      (0, { $0 == 0 } ),
  "vizslas":     (0, { $0 == 0 } ),
  "goldfish":    (5, { $0  < 5 } ),
  "trees":       (3, { $0  > 3 } ),
  "cars":        (2, { $0 == 2 } ),
  "perfumes":    (1, { $0 == 1 } )
]

var aunts = [Aunt]()
while let line = readLine() {
  aunts.append(Aunt.process(line))
}

let ans1 = aunts.first(where: {
  $0.data.allSatisfy( {
    let (key, val) = $0
    return targetData[key]!.0 == val
  } )
} )!.num

let ans2 = aunts.first(where: {
  $0.data.allSatisfy( {
    let (key, val) = $0
    return targetData[key]!.1(val)
  } )
} )!.num

print("Part 1 answer: \(ans1)")
print("Part 2 answer: \(ans2)")
