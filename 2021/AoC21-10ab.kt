import java.io.File

fun main() {
  val input = File("input.txt").readLines()

  var total = 0
  val scores = mutableListOf<Long>()
  outer@ for (line in input) {
    val expected = mutableListOf<Char>()
    for (c in line) {
      if ("([{<".asSequence().contains(c)) {
        expected.add((c.code + if (c == '(') 1 else 2).toChar())
      } else if (c == expected.last()) {
        expected.removeLast()
      } else {
        total += score1(c)
        continue@outer
      }
    }

    scores.add(expected.reversed().map { score2(it).toLong() }.reduce { acc, item -> acc * 5 + item })
  }

  println("Part 1 answer: $total")
  println("Part 2 answer: ${scores.sorted()[scores.size/2]}")
}

fun score1(c: Char): Int {
  return when (c) {
    ')' ->     3
    ']' ->    57
    '}' ->  1197
    '>' -> 25137
    else -> 0
  }
}

fun score2(c: Char): Int {
  return when (c) {
    ')' -> 1
    ']' -> 2
    '}' -> 3
    '>' -> 4
    else -> 0
  }
}
