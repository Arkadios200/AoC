let input = Array(readLine()!)

var layers = [[[Character]]]()
for i in stride(from: 0, to: input.count, by: 150) {
  var tempLayer = [[Character]]()
  for j in stride(from: 0, to: 150, by: 25) {
    tempLayer.append(Array(input[i+j..<i+j+25]))
  }
  layers.append(tempLayer)
}

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

for row in image {
  print(String(row.map( { $0 == "1" ? "█" : " " } )))
}
