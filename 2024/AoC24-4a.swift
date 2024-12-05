import Foundation

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

let input = (try? String(contentsOf: URL(fileURLWithPath: "sample.txt")))!

let tempIn = input.components(separatedBy: "\n")

var wordSearch = [[Character]]()

for s in tempIn {
  wordSearch.append(Array(s))
}

var count = 0
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
            count += 1
          }
        }
      }
    }
  }
}

print(count)