extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

func step(_ pos: inout (Int, Int, Int), _ turn: Bool = false) {
  if turn {
    pos.2 = (pos.2 + 1) % 4
  }
  switch pos.2 {
    case 0:
      pos.1 -= 1
    case 1:
      pos.0 += 1
    case 2:
      pos.1 += 1
    case 3:
      pos.0 -= 1
    default: break
  }
}

var map = [[Character]]()
while let line = readLine() {
  map.append(Array(line))
}

var pos = (0, 0, 0)
find: for (i, e) in map.enumerated() {
  for (j, f) in e.enumerated() {
    if f == "^" {
      pos = (j, i, 0)
      map[i][j] = "."
      break find
    }
  }
}
print(pos)

var posRecord: [(Int, Int)] = [(pos.0, pos.1)]
part1: while true {
  switch pos.2 {
    case 0:
      if let m = map[safe: pos.1-1] {
        if m[pos.0] != "#" {
          step(&pos)
        } else {
          step(&pos, true)
        }
      } else {
        break part1
      }
    case 1:
      if let m = map[pos.1][safe: pos.0+1] {
        if m != "#" {
          step(&pos)
        } else {
          step(&pos, true)
        }
      } else {
        break part1
      }
    case 2:
      if let m = map[safe: pos.1+1] {
        if m[pos.0] != "#" {
          step(&pos)
        } else {
          step(&pos, true)
        }
      } else {
        break part1
      }
    case 3:
      if let m = map[pos.1][safe: pos.0-1] {
        if m != "#" {
          step(&pos)
        } else {
          step(&pos, true)
        }
      } else {
        break part1
      }
    default: break part1
  }

  if !posRecord.contains(where: { $0.0 == pos.0 && $0.1 == pos.1 } ) {
    posRecord.append((pos.0, pos.1))
  }
}

print(posRecord.count)
