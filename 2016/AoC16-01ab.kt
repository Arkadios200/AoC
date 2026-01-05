import java.io.File
import java.util.Objects

fun main() {
  val lines: List<Pair<Char, Int>> = File("input.txt").readText()
    .split(", ")
    .map { Pair(it[0], it.substring(1).toInt()) }

  println("Part 1 answer: ${part1(lines)}")
  println("Part 2 answer: ${part2(lines)}")
}

fun part1(lines: List<Pair<Char, Int>>): Int {
  var nav = Nav()
  for ((dir, dist) in lines) {
    nav.turn(dir)
    nav.step(dist)
  }

  return nav.pos.mDist()
}

fun part2(lines: List<Pair<Char, Int>>): Int {
  val record: MutableSet<Point> = HashSet<Point>()
  var nav = Nav()
  record.add(Point(nav.pos))

  while (true) {
    for ((dir, dist) in lines) {
      nav.turn(dir)
      for (i in 1..dist) {
        if (!record.add(nav.step())) return nav.pos.mDist()
      }
    }
  }
}

class Point(var x: Int, var y: Int) {
  constructor(p: Point) : this(p.x, p.y)

  fun mDist(other: Point = origin): Int = Math.abs(this.x - other.x) + Math.abs(this.y - other.y)

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other == null || this.javaClass != other.javaClass) return false

    val otherPoint: Point = other as Point
    return this.x == otherPoint.x && this.y == otherPoint.y
  }

  override fun hashCode(): Int = Objects.hash(x, y)

  companion object {
    val origin: Point = Point(0, 0)
  }
}

class Nav {
  var pos: Point = Point(Point.origin)
  var dir: Int = 0

  fun turn(d: Char) {
    dir += when (d) {
      'L' -> 3
      'R' -> 1
      else -> throw Exception("Invalid dir: $d")
    }
    dir %= 4
  }

  fun step(n: Int = 1): Point {
    when (this.dir) {
      0 -> this.pos.y += n
      1 -> this.pos.x += n
      2 -> this.pos.y -= n
      3 -> this.pos.x -= n
    }

    return Point(this.pos)
  }
}