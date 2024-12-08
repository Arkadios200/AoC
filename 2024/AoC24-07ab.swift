import Foundation

func exp(_ base: Int, _ power: Int) -> Int {
  var b = 1
  for _ in 0..<power {
    b *= base
  }
  
  return b
}

let input = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!.components(separatedBy: "\n")
var totals = [Int]()
var lists = [[Int]]()
for line in input {
  var tempNums: [String.SubSequence] = line.split(separator: " ")
  tempNums[0] = tempNums[0][tempNums[0].startIndex...tempNums[0].index(tempNums[0].endIndex, offsetBy:-2)]
  totals.append(Int(tempNums[0])!)
  var tempList = [Int]()
  for v in 1..<tempNums.count {
    tempList.append(Int(tempNums[v])!)
  }
  lists.append(tempList)
}

var total1 = 0, total2 = 0
for i in 0..<totals.count {
  let x = exp(2, lists[i].count-1)-1
  for j in 0...x {
    var tempBin = Array(String(j, radix: 2))
    while tempBin.count < lists[i].count-1 {
      tempBin = "0" + tempBin
    }
    var tempTotal1 = lists[i][0]
    for c in 0..<tempBin.count {
      if tempBin[c] == "0" {
        tempTotal1 += lists[i][c+1]
      } else {
        tempTotal1 *= lists[i][c+1]
      }
      if tempTotal1 > totals[i] {
        break
      }
    }
    if tempTotal1 == totals[i] {
      total1 += totals[i]
      break
    } else {
      tempTotal1 = lists[i][0]
    }
  }

  let y = exp(3, lists[i].count-1)-1
  for j in 0...y {
    var tempTern = Array(String(j, radix: 3))
    while tempTern.count < lists[i].count-1 {
      tempTern = "0" + tempTern
    }
    var tempTotal2 = lists[i][0]
    for c in 0..<tempTern.count {
      if tempTern[c] == "0" {
        tempTotal2 += lists[i][c+1]
      } else if tempTern[c] == "1" {
        tempTotal2 *= lists[i][c+1]
      } else {
        tempTotal2 = Int(String(tempTotal2) + String(lists[i][c+1]))!
      }
      if tempTotal2 > totals[i] {
        break
      }
    }

    if tempTotal2 == totals[i] {
      total2 += totals[i]
      break
    } else {
      tempTotal2 = lists[i][0]
    }
  }
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
