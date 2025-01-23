import java.io.File

fun main() {
  val input = File("input.txt").readText().split("\n").map({ it.toInt() })

  val fRecord = mutableListOf(0)

  var found1 = false
  var found2 = false
  day1@ while (true) {
    for (i in input) {
      val freq = fRecord.last() + i
      
      if (fRecord.contains(freq) && !found2) {
        println("Part 2 answer: $freq")
        found2 = true
      }

      if (found1 && found2) { break@day1 }
      
      fRecord.add(freq)
    }
    
    if (!found1) {
      println("Part 1 answer: ${fRecord.last()}")
      found1 = true
    }
  }
}
