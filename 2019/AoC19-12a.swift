

struct Moon {
  var pos: [Int]
  var vel = [0, 0, 0]

  init(x: Int, y: Int, z: Int) {
    self.pos = [x, y, z]
  }

  func pEnergy() -> Int {
    return pos.reduce(0, { $0 + abs($1) } )
  }

  func kEnergy() -> Int {
    return vel.reduce(0, { $0 + abs($1) } )
  }
}

var moons = [
  Moon(x: -15, y: 1, z: 4),
  Moon(x: 1, y: -10, z: -8),
  Moon(x: -5, y: 4, z: 9),
  Moon(x: 4, y: 6, z: -2)
]

for _ in 1...1000 {
  var velChanges = [[Int]](repeating: [0, 0, 0], count: 4)

  for i in 0..<3 {
    for j in 0..<4 {
      for k in 0..<4 where k != j {
        let diff = moons[k].pos[i] - moons[j].pos[i]
        velChanges[j][i] += diff != 0 ? diff/abs(diff) : 0
      }
    }
  }

  for i in 0..<moons.count {
    for j in 0..<moons[i].vel.count {
      moons[i].vel[j] += velChanges[i][j]
      moons[i].pos[j] += moons[i].vel[j]
    }
  }
}

var total1 = 0
for moon in moons {
  total1 += moon.pEnergy() * moon.kEnergy()
}

print("Part 1 answer: \(total1)")
