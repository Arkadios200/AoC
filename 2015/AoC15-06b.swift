var test = [[Int]](repeating: [Int](repeating: 0, count: 1000), count: 1000)

while let line = readLine() {
  let temp = line.split(separator: " ")

  if temp[0] == "toggle" {
    let rangeStart = temp[1].split(separator: ",").map( { Int(String($0))! } )
    let rangeEnd = temp[3].split(separator: ",").map( { Int(String($0))! } )
    for i in rangeStart[0]...rangeEnd[0] {
      for j in rangeStart[1]...rangeEnd[1] {
        test[j][i] += 2
      }
    }
  } else {
    let rangeStart = temp[2].split(separator: ",").map( { Int(String($0))! } )
    let rangeEnd = temp[4].split(separator: ",").map( { Int(String($0))! } )

    for i in rangeStart[0]...rangeEnd[0] {
      for j in rangeStart[1]...rangeEnd[1] {
        test[j][i] += temp[1] == "off" ? (test[j][i] == 0 ? 0 : -1) : 1
      }
    }
  }
}

var total = 0
for i in test {
  for j in i {
    total += j
  }
}

print(total)
