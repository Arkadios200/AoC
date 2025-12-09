func getInput() -> [(Int, Int)] {
  var dirs: [(Int, Int)] = []
  while let line = readLine() {
    let d: Int = {
      switch line.first! {
        case "L": return -1
        case "R": return +1
        default: fatalError()
      }
    }()

    dirs.append((d, Int(line.dropFirst())!))
  }

  return dirs
}

let dirs = getInput()

var dial = 50
var ans1 = 0
var ans2 = 0
for (d, n) in dirs {
  ans2 += n / 100

  for _ in 1...(n % 100) {
    dial += d
    if dial % 100 == 0 { ans2 += 1 }
  }

  if dial % 100 == 0 { ans1 += 1 }
}

print("Part 1 answer:", ans1)
print("Part 2 answer:", ans2)