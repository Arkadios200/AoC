import java.io.File

fun main() {
  val input = File("input.txt").readText().split("\n").map({ it.toInt() })

  var freq = 0
  val fRecord = mutableListOf(freq)

  var found1 = false
  var found2 = false
  while (true) {
    for (i in input) {
      freq += i
      
      if (fRecord.contains(freq)) {
        println("Part 2 answer: $freq")
        found2 = true
      }
      
      fRecord.add(freq)
    }
    if (!found1) {
      println("Part 1 answer: $freq")
      found1 = true
    }

    if (found1 && found2) {break}
  }
}
