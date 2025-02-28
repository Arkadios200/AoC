func process(_ line: String) -> (String, [[String]]) {
  let temp = line.filter( { $0 != " " } ).split(separator: ":", maxSplits: 1)
  let num = temp[0].filter( { $0.isNumber } )
  let totals = temp[1].split(separator: ",").map( { $0.split(separator: ":").map( { String($0) } ) } )

  return (num, totals)
}

let targetAunt1: [String: Int] = [
  "children": 3,
  "cats": 7,
  "samoyeds": 2,
  "pomeranians": 3,
  "akitas": 0,
  "vizslas": 0,
  "goldfish": 5,
  "trees": 3,
  "cars": 2,
  "perfumes": 1
]

let targetAunt2: [String: (Int) -> Bool] = [
  "children": { $0 == 3 },
  "cats": { $0 > 7 },
  "samoyeds": { $0 == 2 },
  "pomeranians": { $0 < 3 },
  "akitas": { $0 == 0 },
  "vizslas": { $0 == 0 },
  "goldfish": { $0 < 5 },
  "trees": { $0 > 3 },
  "cars": { $0 == 2 },
  "perfumes": { $0 == 1 }
]

outer: while let line = readLine() {
  let (num, totals) = process(line)

  var check1 = true
  var check2 = true
  for t in totals {
    if targetAunt1[t[0]]! != Int(t[1])! {
      check1 = false
    }

    if !targetAunt2[t[0]]!(Int(t[1])!) {
      check2 = false
    }
  }
  if check1 { print("Part 1 answer: \(num)") }
  if check2 { print("Part 2 answer: \(num)") }
}
