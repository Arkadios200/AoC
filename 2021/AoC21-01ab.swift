var m1 = [Int]()
while let line = readLine() {
  m1.append(Int(line)!)
}

var total1 = 0
for i in 1..<m1.count where m1[i] > m1[i-1] {
  total1 += 1
}
print("Part 1 answer: \(total1)")

var m2 = [Int]()
for i in 0..<m1.count-2 {
  m2.append(m1[i...i+2].reduce(0, +))
}

var total2 = 0
for i in 1..<m2.count where m2[i] > m2[i-1] {
  total2 += 1
}
print("Part 2 answer: \(total2)")
