import java.io.File

fun main() {
  val input = File("input.txt").readText()

  var count = 0
  var found = false
  for ((i, c) in input.withIndex()) {
    count += when (c) {
      '(' -> 1
      ')' -> -1
      else -> break
    }
    if (count < 0 && !found) {
      println("Part 2 answer: ${i+1}")
      found = true
    }
  }
  println("Part 1 answer: $count")
}