import Foundation

func getGroups(from input: String) -> [[String]] {
  let lines = input.split(separator: "\n", omittingEmptySubsequences: false).map( { String($0) } )
  
  var groups: [[String]] = [[]]
  lines.forEach {
    !$0.isEmpty ? groups[groups.indices.last!].append($0) : groups.append([])
  }

  return groups
}

let input = try! String(contentsOf: URL(fileURLWithPath: "input.txt"))
let groups = getGroups(from: input)

let total1 = groups.map( { Set($0.joined()).count } ).reduce(0, +)

let total2 = groups.map( {
  g in
  g.first!.filter( {
    c in g.allSatisfy( { $0.contains(c) } )
  } ).count
} ).reduce(0, +)

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
