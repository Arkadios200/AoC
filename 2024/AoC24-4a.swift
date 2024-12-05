import Foundation

// This part wasn't written by me. Sorry.
extension Collection {
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

func getValue(of input: [[Character]], at ij: [Int]) -> String {
  if let x = input[safe: ij[0]] {
    if let y = x[safe: ij[1]] {
      return String(y)
    }
  }
  return ""
}

let input = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!

var wordSearch = [[Character]]()
for s in input.components(separatedBy: "\n") {
  wordSearch.append(Array(s))
}

var total1 = 0
for i in 0..<wordSearch.count {
  for j in 0..<wordSearch[i].count {
    if wordSearch[i][j] == "X" {
      var tempStrings: [String] = ["", "", "", "", "", "", "", ""]
      for k in 1...3 {
        let locations: [[Int]] = [
          [i, j+k],
          [i+k, j+k],
          [i+k, j],
          [i+k, j-k],
          [i, j-k],
          [i-k, j-k],
          [i-k, j],
          [i-k, j+k]
        ]
        for m in 0..<8 {
          tempStrings[m] += getValue(of: wordSearch, at: locations[m])
        }
        for s in tempStrings {
          if s == "MAS" {
            total1 += 1
          }
        }
      }
    }
  }
}

print("Part 1 answer: \(total1)")