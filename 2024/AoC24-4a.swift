import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

func getValue(of input: [[Character]], at ij: [Int]) -> String {
  if let a = input[safe: ij[0]] {
    if let b = x[safe: ij[1]] {
      return String(b)
    }
  }
  return ""
}

let input = (try? String(contentsOf: URL(fileURLWithPath: "sample.txt")))!
let tempInput = input.components(separatedBy: "\n")

var wordSearch = [[Character]]()

for s in tempInput {
  wordSearch.append(Array(s))
}

var count = 0
for i in 0..<wordSearch.count {
  for j in 0..<wordSearch[i].count {
    if wordSearch[i][j] == "X" {
      var tempStrings: [String] = ["", "", "", "", "", "", "", ""]
      for k in 1...3 {
        tempStrings[0] += getValue(of: wordSearch, at: [i, j+k])  
        tempStrings[1] += getValue(of: wordSearch, at: [i+k, j+k])
        tempStrings[2] += getValue(of: wordSearch, at: [i+k, j])
        tempStrings[3] += getValue(of: wordSearch, at: [i+k, j-k])
        tempStrings[4] += getValue(of: wordSearch, at: [i, j-k])
        tempStrings[5] += getValue(of: wordSearch, at: [i-k, j-k])
        tempStrings[6] += getValue(of: wordSearch, at: [i-k, j])
        tempStrings[7] += getValue(of: wordSearch, at: [i-k, j+k])
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
