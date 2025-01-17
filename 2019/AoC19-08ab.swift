let input = Array(readLine()!)

var layers = [[[Character]]]()
for i in stride(from: 0, to: input.count, by: 150) {
  var tempLayer = [[Character]]()
  for j in stride(from: 0, to: 150, by: 25) {
    tempLayer.append(Array(input[i+j..<i+j+25]))
  }
  layers.append(tempLayer)
}

var counts = [Character: Int]()
var zeroes = 150
part1: for layer in layers {
  var layerCounts = [Character: Int]()
  for row in layer {
    for pixel in row {
      layerCounts[pixel] = (layerCounts[pixel] ?? 0) + 1
      if (layerCounts["0"] ?? 0) > zeroes { continue part1 }
    }
  }
  if (layerCounts["0"] ?? 0) < zeroes {
    counts = layerCounts
    zeroes = layerCounts["0"] ?? 0
  }
}

print("Part 1 answer: \((counts["1"] ?? 0) * (counts["2"] ?? 0))")

var image = [[Character]](repeating: [Character](repeating: "x", count: 25), count: 6)
for i in 0..<image.count {
  for j in 0..<image[i].count {
    for layer in layers {
      if layer[i][j] != "2" {
        image[i][j] = layer[i][j]
        break
      }
    }
  }
}

print("Part 2 answer:")
for row in image {
  print(String(row.map( { $0 == "1" ? "█" : " " } )))
}
