import Foundation

struct Lens {
  let label: String
  var focalLength: Int

  init(_ label: String, _ focalLength: Int) {
    self.label = label
    self.focalLength = focalLength
  }
}

func hash(_ s: String) -> Int {
  return s.reduce(0, { (($0 + Int($1.asciiValue!)) * 17) % 256 } )
}

let input = (try? String(contentsOf: URL(fileURLWithPath: "input.txt")))!.split(separator: ",").map( { String($0) } )

print("Part 1 answer: \(input.reduce(0, { $0 + hash($1) } ))")

var boxes = [[Lens]](repeating: [], count: 256)
loop: for line in input {
  let index = line.firstIndex(where: { "-=".contains($0) } )!
  
  let label = String(line.prefix(upTo: index))
  let box = hash(label)
  
  switch line[index] {
    case "-":
      boxes[box] = boxes[box].filter( { $0.label != label } )
    case "=":
      let focalLength = Int(String(line.last!))!
      if let i = boxes[box].firstIndex(where: { $0.label == label } ) {
        boxes[box][i].focalLength = focalLength
      } else {
        boxes[box].append(Lens(label, focalLength))
      }
    default:
      print("Something broke.")
      break loop
  }
}

var total2 = 0
for (i, box) in boxes.enumerated() {
  for (j, lens) in box.enumerated() {
    total2 += (i + 1) * (j + 1) * lens.focalLength
  }
}
print("Part 2 answer: \(total2)")
