func nice1(_ s: String) -> Bool {
  let cond1 = s.filter( { "aeiou".contains($0) } ).count >= 3

  let indices = s.indices
  let cond2 = indices[..<indices.index(before: indices.endIndex)]
    .contains(where: { s[$0] == s[s.index(after: $0)] } )

  let cond3 = ["ab", "cd", "pq", "xy"].filter( { s.contains($0) } ).count == 0
  
  return cond1 && cond2 && cond3
}

func nice2(_ s: String) -> Bool {
  let indices = s.indices

  let cond1 = indices[..<indices.index(indices.endIndex, offsetBy: -3)]
  .contains(where: {
    indices[indices.index($0, offsetBy: 2)..<indices.index(before: indices.endIndex)]
    .map( { s[$0...s.index(after: $0)] } )
    .contains(s[$0...s.index(after: $0)])
  } )
  
  let cond2 = indices[..<indices.index(indices.endIndex, offsetBy: -2)].contains(where: { s[$0] == s[s.index($0, offsetBy: 2)] } )
  
  return cond1 && cond2
}

let input = (try! String(contentsOf: URL(fileURLWithPath: "input.txt"))).split(separator: "\n").map( { String($0) } )

print("Part 1 answer: \(input.filter( { nice1($0) } ).count)")
print("Part 2 answer: \(input.filter( { nice2($0) } ).count)")
