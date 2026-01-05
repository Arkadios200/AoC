import 'dart:io';
import 'dart:core';
import 'dart:collection';

void main() {
  final List<(String, int)> lines = File('input.txt').readAsStringSync()
    .split(', ')
    .map((line) => (line[0], int.parse(line.substring(1))))
    .toList();

  print('Part 1 answer: ${part1(lines)}');
  print('Part 2 answer: ${part2(lines)}');
}

int part1(List<(String, int)> lines) {
  Nav nav = Nav.start();
  for (final (dir, dist) in lines) {
    nav.turn(dir);
    nav.step(dist);
  }

  return nav.pos.mDist(Point.origin);
}

int part2(List<(String, int)> lines) {
  Set<Point> record = HashSet<Point>();
  Nav nav = Nav.start();
  while (true) {
    for (final (dir, dist) in lines) {
      nav.turn(dir);
      for (int i = 0; i < dist; i++) {
        if (!record.add(nav.step())) return nav.pos.mDist(Point.origin);
      }
    }
  }
}

class Point {
  int x, y;

  Point(this.x, this.y);
  Point.clone(Point p) : this(p.x, p.y);

  static final Point origin = Point(0, 0);

  bool operator ==(Object o) {
    return o is Point && this.x == o.x && this.y == o.y;
  }

  int get hashCode => Object.hash(x, y);

  int mDist(Point other) => (this.x - other.x).abs() + (this.y - other.y).abs();

  String toString() => 'Point($x, $y)';
}

class Nav {
  Point pos;
  int dir;

  Nav(this.pos, this.dir);
  Nav.start() : this(Point.clone(Point.origin), 0);

  void turn(String s) {
    this.dir += switch (s) {
      'L' => 3,
      'R' => 1,
      _ => throw Exception('Invalid dir: $s')
    };
    this.dir %= 4;
  }

  Point step([int n = 1]) {
    switch (this.dir) {
      case 0: this.pos.y += n;
      case 1: this.pos.x += n;
      case 2: this.pos.y -= n;
      case 3: this.pos.x -= n;
    }

    return Point.clone(this.pos);
  }
}