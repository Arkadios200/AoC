import Foundation

func addDuple(_ a: (Int, Int), _ b: (Int, Int)) -> (Int, Int) {
  return (a.0 + b.0, a.1 + b.1)
}

func withinBounds(_ antinode: (Int, Int), of map: [[Character]]) -> Bool {
  let maxHeight = map.count
  let maxWidth = map[0].count
  
  return (antinode.1 < maxWidth && antinode.1 >= 0) && (antinode.0 < maxHeight && antinode.0 >= 0)
}

func getAntinodes1(_ a: [(Int, Int)]) -> [(Int, Int)] {
  var antinodes = [(Int, Int)]()

  for i in 0..<a.count-1 {
    for j in i+1..<a.count {
      var vector = (a[i].0-a[j].0, a[i].1-a[j].1)
      var new1 = addDuple(a[i], vector)
      if new1 == a[j] {
        vector = (-vector.0, -vector.1)
        new1 = addDuple(a[i], vector)
      }
      vector = (a[i].0-a[j].0, a[i].1-a[j].1)
      var new2 = addDuple(a[j], vector)
      if new2 == a[i] {
        vector = (-vector.0, -vector.1)
        new2 = addDuple(a[j], vector)
      }
      if withinBounds(new1, of: map) {
        antinodes.append(new1)
      }
      if withinBounds(new2, of: map) {
        antinodes.append(new2)
      }
    }
  }

  return antinodes
}

func walk(from start: (Int, Int), along vector: (Int, Int), excluding antinodes: [(Int, Int)]) -> [(Int, Int)] {
  var newAntinode = start
  var newAntinodes = [(Int, Int)]()
  while true {
    newAntinode = addDuple(newAntinode, vector)
    if !withinBounds(newAntinode, of: map) {break}
    if !antinodes.contains(where: {$0 == newAntinode}) {
      newAntinodes.append(newAntinode)
    }
  }

  return newAntinodes
}

func getAntinodes2(_ a: [(Int, Int)]) -> [(Int, Int)] {
  var antinodes = [(Int, Int)]()

  for i in 0..<a.count-1 {
    for j in i+1..<a.count {
      var vector = (a[i].0-a[j].0, a[i].1-a[j].1)
      antinodes += walk(from: (a[i].0, a[i].1), along: vector, excluding: antinodes)
      antinodes += walk(from: (a[j].0, a[j].1), along: vector, excluding: antinodes)

      vector = (-vector.0, -vector.1)
      antinodes += walk(from: (a[i].0, a[i].1), along: vector, excluding: antinodes)
      antinodes += walk(from: (a[j].0, a[j].1), along: vector, excluding: antinodes)
    }
  }

  return antinodes
}

var map = [[Character]]()
while let line = readLine() {
  map.append(Array(line))
}

var antennae = [Character: [(Int, Int)]]()
for i in 0..<map.count {
  for j in 0..<map[i].count where map[i][j] != "." {
    let temp = map[i][j]
    if var a = antennae[temp] {
      a.append((i, j))
      antennae[temp] = a
    } else {
      antennae[temp] = [(i, j)]
    }
  }
}

var antinodeRecord1 = [(Int, Int)]()
var antinodeRecord2 = [(Int, Int)]()
for (_, val) in antennae {
  let antinodes1 = getAntinodes1(val)
  let antinodes2 = getAntinodes2(val)
  for a in antinodes1 where !antinodeRecord1.contains(where: {$0 == a}) {
    antinodeRecord1.append(a)
  }
  for b in antinodes2 where !antinodeRecord2.contains(where: {$0 == b}) {
    antinodeRecord2.append(b)
  }
}
  
let total1 = antinodeRecord1.count
print("Part 1 answer: \(total1)")

let total2 = antinodeRecord2.count
print("Part 2 answer: \(total2)")
