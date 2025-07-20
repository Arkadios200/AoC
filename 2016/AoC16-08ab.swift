func getInput() -> [String] {
  var lines: [String] = []
  while let line = readLine() { lines.append(line) }

  return lines
}

let width = 50
let height = 6

let lines = getInput()

var screen: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: width), count: height)

for line in lines {
  let temp = line.split(separator: " ", maxSplits: 2)

  if temp.first! == "rect" {
    let n = temp.last!.split(separator: "x").map { Int($0)! }
    let (a, b) = (n[0], n[1])

    for i in 0..<b {
      for j in 0..<a {
        screen[i][j] = true
      }
    }
  } else {
    let n = temp.last!.split { !$0.isNumber }.map { Int($0)! }
    let (a, b) = (n[0], n[1])
    if temp[1] == "row" {
      let row = screen[a]
      for j in 0..<width {
        screen[a][(j + b) % width] = row[j]
      }
    } else if temp[1] == "column" {
      let col = screen.map { $0[a] }
      for i in 0..<height {
        screen[(i + b) % height][a] = col[i]
      }
    }
  }
}

print(screen.joined().filter { $0 }.count)
screen.forEach { print(String($0.map { $0 ? "█" : " " })) }