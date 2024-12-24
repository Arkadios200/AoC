func getContents(of s: String) -> [Character: Int] {
  var contents = [Character: Int]()
  for i in s.indices {
    contents[s[i]] = 1 + (contents[s[i]] != nil ? contents[s[i]]! : 0) 
  }

  return contents
}

func anagramChecker(_ a: String, _ b: String) -> Bool {
  return getContents(of: a) == getContents(of: b)
}

var total1 = 0, total2 = 0
while let ln = readLine() {
  var valid1 = true, valid2 = true
  
  let line = ln.split(separator: " ").map( { String($0) } )
  running: for i in 0..<line.count-1 {
    for j in i+1..<line.count {
      if line[i] == line[j] {
        valid1 = false
      }
      if anagramChecker(line[i], line[j]) {
        valid2 = false
      }
      
      if !(valid1 || valid2) {
        break running
      }
    }
  }

  total1 += valid1 ? 1 : 0
  total2 += valid2 ? 1 : 0
}

print("Part 1 answer: \(total1)")
print("Part 2 answer: \(total2)")