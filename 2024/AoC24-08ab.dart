import 'dart:io';
import 'dart:core';
import 'dart:collection';

void main() {
  final String input = File('input.txt').readAsStringSync();

  final (antennae, bounds) = process(input);

  print('Part 1 answer: ${part1(antennae, bounds)}');
  print('Part 2 answer: ${part2(antennae, bounds)}');
}

int part1(List<List<Point>> antennae, Point bounds) {
  Set<Point> antinodes = HashSet<Point>();

  for (final group in antennae) {
    for (final (a, b) in group.unorderedPairs()) {
      final Point diff = a - b;
      antinodes.add(a + diff);
      antinodes.add(b - diff);
    }
  }

  return antinodes.where((p) => p.isWithin(bounds)).length;
}

int part2(List<List<Point>> antennae, Point bounds) {
  Set<Point> record = HashSet<Point>();

  for (final group in antennae) {
    for (var (a, b) in group.unorderedPairs()) {
      final Point diff = a - b;
      while (a.isWithin(bounds)) {
        record.add(a);
        a += diff;
      }
      while (b.isWithin(bounds)) {
        record.add(b);
        b -= diff;
      }
    }
  }

  return record.length;
}

(List<List<Point>>, Point) process(String input) {
  final List<List<String>> grid = input.split('\n').map((line) => line.split('').toList()).toList();

  Map<String, List<Point>> antennae = Map();
  for (final (i, row) in grid.enumerate()) {
    for (final (j, c) in row.enumerate()) {
      if (c == '.') continue;
      List<Point> v = antennae[c] ?? [];
      v.add(Point(j, i));
      antennae[c] = v;
    }
  }

  final int width = grid[0].length;
  final int height = grid.length;
  final Point bounds = Point(width, height);

  return (antennae.values.toList(), bounds);
}

class Point {
  final int x, y;

  Point(this.x, this.y);
  Point.clone(Point p) : this(p.x, p.y);

  bool isWithin(Point bounds) =>
    0 <= this.x && this.x < bounds.x && 0 <= this.y && this.y < bounds.y;

  Point operator +(Point other) =>
    Point(this.x + other.x, this.y + other.y);

  Point operator -(Point other) =>
    Point(this.x - other.x, this.y - other.y);

  @override
  bool operator ==(Object o) =>
    o is Point && this.x == o.x && this.y == o.y;

  @override
  int get hashCode => Object.hash(x, y);
}

extension <E> on List<E> {
  List<(int, E)> enumerate([start = 0]) {
    List<(int, E)> out = [];
    for (final E e in this) out.add((start++, e));

    return out;
  }

  List<(E, E)> unorderedPairs() {
    List<(E, E)> out = [];
    for (final (i, e) in this.enumerate().sublist(1)) {
      out.addAll(this.sublist(0, i).map((f) => (e, f)));
    }

    return out;
  }
}