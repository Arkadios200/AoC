let playerCount = 13
let finalScore = 7999

var test = [0]
var players = [Int](repeating: 0, count: playerCount)
var p = 0
var j = 0
for i in 1...finalScore {
  if i % 23 == 0 {
    if j < 7 {
      j = test.count - (7 - j)
    } else {
      j -= 7
    }
    players[p] += i + test.remove(at: j)
  } else {
    j = (j + 1) % test.count + 1
    test.insert(i, at: j)
  }
  p = (p + 1) % players.count
}

print(players.max()!)
