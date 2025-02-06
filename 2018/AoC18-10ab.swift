import Foundation

struct Light {
  private var pos: (x: Int, y: Int)
  private let vel: (x: Int, y: Int)

  init(_ nums: [Int]) {
    pos = (nums[0], nums[1])
    vel = (nums[2], nums[3])
  }

  mutating func step() {
    pos.x += vel.x
    pos.y += vel.y
  }

  static func skyMap(of lights: [Light]) -> [[Character]]? {
    let width  = 1 + lights.max(by: { $0.pos.x < $1.pos.x } )!.pos.x - lights.min(by: { $0.pos.x < $1.pos.x } )!.pos.x
    let height = 1 + lights.max(by: { $0.pos.y < $1.pos.y } )!.pos.y - lights.min(by: { $0.pos.y < $1.pos.y } )!.pos.y

    if height != (lights.count == 31 ? 8 : 10) {
      return nil
    }

    var map = [[Character]](repeating: [Character](repeating: " ", count: width), count: height)
    for light in lights {
      let i = light.pos.y - lights.min(by: { $0.pos.y < $1.pos.y } )!.pos.y
      let j = light.pos.x - lights.min(by: { $0.pos.x < $1.pos.x } )!.pos.x

      map[i][j] = "█"
    }

    return map
  }
}

var lights: [Light] = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!
.split(separator: "\n")
.map( { Light(
  $0
  .filter( { " -1234567890".contains($0) } )
  .split(separator: " ")
  .map( { Int($0)! } )
) } )

var count = 0
while true {
  count += 1
  for i in 0..<lights.count {
    lights[i].step()
  }

  if let map = Light.skyMap(of: lights) {
    print("Part 1 answer:")
    map.forEach( { print(String($0)) } )
    break
  }
}
print("Part 2 answer: \(count)")
