class Item {
  let cost: Int

  init(_ cost: Int) {
    self.cost = cost
  }
}

class Weapon: Item {
  let damage: Int

  init(c cost: Int, d damage: Int) {
    self.damage = damage
    super.init(cost)
  }
}

class Armor: Item {
  let armor: Int

  init(c cost: Int, a armor: Int) {
    self.armor = armor
    super.init(cost)
  }
}

class Ring: Item {
  let damage: Int?
  let armor: Int?

  init(c cost: Int, d damage: Int? = nil, a armor: Int? = nil) {
    self.damage = damage
    self.armor = armor
    super.init(cost)
  }
}

struct Player {
  var health = 100
  let armor: Int
  let damage: Int
  let cost: Int

  init(_ equipment: [Item]) {
    var dam = 0
    var arm = 0

    for item in equipment {
      if let w = item as? Weapon {
        dam += w.damage
      } else if let a = item as? Armor {
        arm += a.armor
      } else if let r = item as? Ring {
        arm += r.armor ?? 0
        dam += r.damage ?? 0
      }
    }

    self.damage = dam
    self.armor = arm
    self.cost = equipment.reduce(0) { $0 + $1.cost }
  }
}

func fight(_ player: Player) -> (Bool, Int) {
  var player = player
  var boss = (health: 104, damage: 8, armor: 1)
  var alive = true
  
  while true {
    boss.health -= max(1, player.damage - boss.armor)
    if boss.health <= 0 {
      break
    }

    player.health -= max(1, boss.damage - player.armor)
    if player.health <= 0 {
      alive = false
      break
    }
  }

  return (alive, player.cost)
}

let weapons: [Weapon] = [
  Weapon(c: 8, d: 4),
  Weapon(c: 10, d: 5),
  Weapon(c: 25, d: 6),
  Weapon(c: 40, d: 7),
  Weapon(c: 74, d: 8)
]

let armors: [Armor] = [
  Armor(c: 0, a: 0),
  Armor(c: 13, a: 1),
  Armor(c: 31, a: 2),
  Armor(c: 53, a: 3),
  Armor(c: 75, a: 4),
  Armor(c: 102, a: 5)
]

let rings: [Ring] = [
  Ring(c: 0, a: 0),
  Ring(c: 0, a: 0),
  Ring(c: 25, d: 1),
  Ring(c: 50, d: 2),
  Ring(c: 100, d: 3),
  Ring(c: 20, a: 1),
  Ring(c: 40, a: 2),
  Ring(c: 80, a: 3)
]

var winCosts = [Int]()
var loseCosts = [Int]()

for w in weapons {
  for a in armors {
    for r1 in 0..<(rings.count-1) {
      for r2 in (r1+1)..<rings.count {
        let (alive, cost) = fight(Player([w, a, rings[r1], rings[r2]]))
        alive ? winCosts.append(cost) : loseCosts.append(cost)
      }
    }
  }
}

print("Part 1 answer: \(winCosts.min()!)")
print("Part 2 answer: \(loseCosts.max()!)")
