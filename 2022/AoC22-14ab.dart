import 'dart:io';
import 'dart:core';
import 'dart:collection';
import 'dart:math';

void main() {
  final String input = File('input.txt').readAsStringSync();

  final Set<Point> walls = process(input);

  print('Part 1 answer: ${part1(walls)}');
  print('Part 2 answer: ${part2(walls)}');
}

int part1(Set<Point> walls) {
  Set<Point> record = HashSet<Point>();

  int bottom = 0;
  for (final Point p in walls) {
    if (bottom < p.y) bottom = p.y;
  }

  while (true) {
    Point sand = Point.clone(Point.newSand);
    while (true) {
      if (sand.y > bottom) return record.length;

      Point? nextPoint = [0, -1, 1]
        .map((n) => sand + Point(n, 1))
        .firstWhereOrNull((p) => !walls.contains(p) && !record.contains(p));
      if (nextPoint != null) sand = nextPoint;
      else {
        record.add(sand);
        break;
      }
    }
  }
}

int part2(Set<Point> walls) {
  Set<Point> record = HashSet<Point>();

  int bottom = 0;
  for (final Point p in walls) {
    if (bottom < p.y) bottom = p.y;
  }
  bottom += 1;

  while (!record.contains(Point.newSand)) {
    Point sand = Point.clone(Point.newSand);
    while (true) {
      if (sand.y == bottom) {
        record.add(sand);
        break;
      }

      Point? nextPoint = [0, -1, 1]
        .map((n) => sand + Point(n, 1))
        .firstWhereOrNull((p) => !walls.contains(p) && !record.contains(p));
      if (nextPoint != null) sand = nextPoint;
      else {
        record.add(sand);
        break;
      }
    }
  }

  return record.length;
}

Set<Point> process(String input) {

  List<List<Point>> lines = input.split('\n').map((line) {
    return line.split(' -> ').map((s) {
      List<int> temp = s.split(',').map(int.parse).toList();
      return Point(temp[0], temp[1]);
    }).toList();
  }).toList();

  Set<Point> walls = HashSet<Point>();
  for (final line in lines) {
    for (final (a, b) in line.tupleWindows()) {
      if ((a.x == b.x) == (a.y == b.y)) exit(1);

      if (a.x != b.x) {
        for (int i = min(a.x, b.x); i <= max(a.x, b.x); i++) {
          walls.add(Point(i, a.y));
        }
      } else if (a.y != b.y) {
        for (int i = min(a.y, b.y); i <= max(a.y, b.y); i++) {
          walls.add(Point(a.x, i));
        }
      }
    }
  }

  return walls;
}

class Point {
  int x, y;

  Point(this.x, this.y);
  Point.clone(Point p) : this(p.x, p.y);

  @override
  bool operator ==(Object o) {
    return o is Point && this.x == o.x && this.y == o.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  Point operator +(Point other) => Point(this.x + other.x, this.y + other.y);

  @override
  String toString() => 'Point($x, $y)';

  static final Point newSand = Point(500, 0);
}

extension <E> on List<E> {
  List<(E, T)> zip<T>(List<T> other) {
    final int l = min(this.length, other.length);

    List<(E, T)> out = [];
    for (int i = 0; i < l; i++) {
      out.add((this[i], other[i]));
    }

    return out;
  }

  List<(E, E)> tupleWindows() {
    return this.zip(this.sublist(1));
  }
}

extension <E> on Iterable<E> {
  E? firstWhereOrNull(bool test(E element)) {
    try {
      return this.firstWhere(test);
    } on StateError {
      return null;
    }
  }
}