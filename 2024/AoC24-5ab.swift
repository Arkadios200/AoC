import Foundation

struct OrderRule {
  var num1: Int = 0
  var num2: Int = 0

  init(_ input: String) {
    for i in input.indices {
      if input[i] == "|" {
        self.num1 = Int(input[input.startIndex...input.index(before: i)])!
        self.num2 = Int(input[input.index(after: i)...input.index(before: input.endIndex)])!
      }
    }
  }
}

struct Update {
  var pages = [Int]()

  init(_ input: String) {
    let temp = input.components(separatedBy: ",")
    for i in temp {
      self.pages.append(Int(i)!)
    }
  }
}

let data = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!
let lines: [String] = data.components(separatedBy: "\n")

var orderRules = [OrderRule]()
var updates = [Update]()
for line in lines {
  if line == "" {continue}
  if line.contains("|") {
    orderRules.append(OrderRule(line))
  } else {
    updates.append(Update(line))
  }
}

var total1 = 0, total2 = 0
for u in updates {
  var found = false
  for i in 0..<u.pages.count-1 {
    for j in i..<u.pages.count {
      for o in orderRules {
        if o.num1 == u.pages[j] && o.num2 == u.pages[i] {
          found = true
        }
      }
    }
  }
  if !found {
    total1 += u.pages[Int(floor(Double(u.pages.count)/2))]
  } else {
    var tempU = u
    for i in 0..<tempU.pages.count {
      for j in i..<tempU.pages.count {
        for k in orderRules {
          if k.num1 == tempU.pages[j] && k.num2 == tempU.pages[i] {
            let tempI = tempU.pages[i]
            tempU.pages[i] = tempU.pages[j]
            tempU.pages[j] = tempI
          }
        }
      }
    }
    total2 += tempU.pages[Int(floor(Double(tempU.pages.count)/2))]
  }
}
print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")
