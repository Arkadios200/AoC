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

var total1 = 0, total2 = 0
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
        for s in tempStrings where s == "MAS" {
          total1 += 1
        }
      }
    } else if wordSearch[i][j] == "A" {
      let locations: [[Int]] = [
        [i-1, j-1],
        [i+1, j-1],
        [i+1, j+1],
        [i-1, j+1]
      ]
      var mCount = 0, sCount = 0
      var temp = [String]()
      for k in locations {
        let tempChar = getValue(of: wordSearch, at: k)
        temp.append(tempChar)
        if tempChar == "M" {
          mCount += 1
        } else if tempChar == "S" {
          sCount += 1
        }
      }
      if mCount == 2 && sCount == 2 && temp[0] != temp[2] && temp[1] != temp[3] {
        total2 += 1
      }
    }
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")