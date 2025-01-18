func cut(_ n: Int, _ deck: inout [Int]) -> Void {
  var temp = [Int]()
  if n > 0 {
    temp = Array(deck.prefix(n))
    deck.removeFirst(n)
    deck += temp
  } else if n < 0 {
    let n = abs(n)
    temp = Array(deck.suffix(n))
    deck.removeLast(n)
    deck = temp + deck
  }
}

func dealWithIncrement(_ n: Int, _ deck: inout [Int]) -> Void {
  var temp = [Int](repeating: 0, count: deck.count)
  for i in 0..<deck.count {
    temp[(n * i) % temp.count] = deck[i]
  }
  deck = temp
}

var deck = [Int](repeating: 0, count: 10007)
for i in 0..<deck.count {
  deck[i] = i
}

while let line = readLine() {
  let temp = line.split(separator: " ")
  if temp[0] == "deal" {
    if temp.contains("increment") {
      let n = Int(temp.last!)!
      dealWithIncrement(n, &deck)
    } else {
      deck.reverse()
    }
  } else {
    let n = Int(temp.last!)!
    cut(n, &deck)
  }
}

print("Part 1 answer: \(deck.firstIndex(of: 2019)!)")
