func transpose<T>(of grid: [[T]]) -> [[T]]? {
  guard Set(grid.map { $0.count }).count == 1 else { return nil }

  return grid.first!.indices.map {
    i in grid.map { $0[i] }
  }
}

func getInput() -> ([[Character]], [(Int, Int, Int)]) {
  var stacks: [[Character]] = []
  while let line = readLine() {
    if line.contains(where: { $0.isNumber } ) { break }

    let temp = Array(line)

    stacks.append(temp.indices.compactMap { $0 % 4 == 1 ? temp[$0] : nil })
  }

  var dirs: [(Int, Int, Int)] = []
  while let line = readLine() {
    if line.isEmpty { continue }

    let a = line.split { !$0.isNumber }.map { Int($0)! }

    dirs.append((a[0], a[1]-1, a[2]-1))
  }

  return (transpose(of: stacks)!.map {
    $0.reversed().filter { $0.isLetter }
  }, dirs)
}

func part1(_ stacks: [[Character]], _ dirs: [(Int, Int, Int)]) -> String {
  var stacks = stacks

  for (num, from, to) in dirs {
    for _ in 0..<num {
      stacks[to].append(stacks[from].removeLast())
    }
  }

  return String(stacks.compactMap { $0.last })
}

func part2(_ stacks: [[Character]], _ dirs: [(Int, Int, Int)]) -> String {
  var stacks = stacks

  for (num, from, to) in dirs {
    let taken = stacks[from].suffix(num)
    stacks[from].removeLast(num)

    stacks[to] += taken
  }

  return String(stacks.compactMap { $0.last })
}

let (stacks, dirs) = getInput()

let ans1 = part1(stacks, dirs)
print("Part 1 answer: \(ans1)")

let ans2 = part2(stacks, dirs)
print("Part 2 answer: \(ans2)")