let playerCount = 13
let finalScore = 7999

var ring = [0]
var players = [Int](repeating: 0, count: playerCount)

var p = 0
var j = 0
for i in 1...finalScore {
  if i % 23 == 0 {
    j += -7 + (j < 7 ? ring.count : 0)
    players[p] += i + ring.remove(at: j)
  } else {
    j = (j + 1) % ring.count + 1
    ring.insert(i, at: j)
  }
  p = (p + 1) % players.count
}

print(players.max()!)
