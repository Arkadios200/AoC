import Foundation

var input = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!
if input[input.index(before: input.endIndex)] != "\n" {
  input.append("\n")
}

var list1 = [Int](), list2 = [Int]()
var temp = ""
for c: Character in input {
  if c >= "0" && c <= "9" {
    temp.append(c)
  } else if c == " " && temp != "" {
    list1.append(Int(temp)!)
    temp = ""
  } else if c == "\n" {
    list2.append(Int(temp)!)
    temp = ""
  }
}

list1.sort()
list2.sort()

var total1 = 0
for i in 0..<list1.count {
  total1 += abs(list1[i] - list2[i])
}
print("Part 1 answer: \(total1)")

var total2 = 0
for num1 in list1 {
  var count = 0
  for num2 in list2 {
    count += (num1 == num2 ? 1 : 0)
  }
  total2 += num1 * count
}
print("Part 2 answer: \(total2)")
