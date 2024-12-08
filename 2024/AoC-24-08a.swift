import Foundation

func getAntinodes(_ a: [(Int, Int)]) -> [(Int, Int)] {
  var antinodes = [(Int, Int)]()

  for i in 0..<a.count-1 {
    for j in i+1..<a.count {
      let distY = a[i].0-a[j].0
      let distX = a[i].1-a[j].1
      var new1 = (a[i].0 + distY, a[i].1 + distX)
      if new1 == a[j] {
        new1 = (a[i].0 - distY, a[i].1 - distX)
      }
      var new2 = (a[j].0 + distY, a[j].1 + distX)
      if new2 == a[i] {
        new2 = (a[j].0 - distY, a[j].1 - distX)
      }
      antinodes.append(new1)
      antinodes.append(new2)
    }
  }

  return antinodes
}

func withinBounds(_ antinode: (Int, Int), of map: [[Character]]) -> Bool {
  let maxHeight = map.count
  let maxWidth = map[0].count
  
  return (antinode.1 < maxWidth && antinode.1 >= 0) && (antinode.0 < maxHeight && antinode.0 >= 0)
}

var map = [[Character]]()
let input = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!.components(separatedBy: "\n")
for line in input {
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

var antinodeRecord = [(Int, Int)]()
for (_, val) in antennae {
  let antinodes = getAntinodes(val)
  for a in antinodes where withinBounds(a, of: map) && !antinodeRecord.contains(where: {$0 == a}) {
    antinodeRecord.append(a)
  }
}

let total1 = antinodeRecord.count
print("Part 1 answer: \(total1)")
