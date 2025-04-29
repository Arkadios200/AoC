func getInput() -> [[[Character]]] {
  var input = Array(readLine()!)
  let width = 25
  let height = 6

  var layers: [[[Character]]] = []
  var layer: [[Character]] = []
  for _ in stride(from: 0, to: input.count, by: width * height) {
    for _ in 1...height {
      layer.append(Array(input.prefix(width)))
      input.removeFirst(width)
    }
    layers.append(layer)
    layer.removeAll()
  }

  return layers
}

let layers = getInput()

let temp = layers.map { $0.joined() }.min(by: { $0.filter { $0 == "0" }.count < $1.filter { $0 == "0" }.count } )!
let ans1 = temp.filter { $0 == "1" }.count * temp.filter { $0 == "2" }.count

print("Part 1 answer: \(ans1)")

let ans2: String = layers.first!.indices.map {
  i in
  layers.first![i].indices.map {
    j in
    layers.first { $0[i][j] != "2" }![i][j] == "1" ? "█" : " "
  }.joined()
}.joined(separator: "\n")

print("Part 2 answer:\n\(ans2)")