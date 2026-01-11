import 'dart:io';
import 'dart:core';
import 'dart:collection';

void main() {
  final List<(String, int)> lines = File('input.txt').readAsStringSync()
    .split('\n')
    .map(process)
    .toList();

  print('Part 1 answer: ${calc(lines, 2)}');
  print('Part 2 answer: ${calc(lines, 10)}');
}

int calc(List<(String, int)> lines, int len) {
  Set<Point> record = HashSet<Point>();
  List<Point> rope = List<Point>.generate(len, (_) => Point.clone(Point.origin));
  record.add(Point.clone(rope.last));

  for (final (dir, dist) in lines) {
    for (int i = 0; i < dist; i++) {
      rope[0].step(dir);
      for (int j = 1; j < rope.length; j++) {
        if ((rope[j].x - rope[j-1].x).abs() > 1 || (rope[j].y - rope[j-1].y).abs() > 1) {
          Point temp = rope[j];
          for (final Point p in rope[j].adjs) {
            if (temp.mDist(rope[j-1]) > p.mDist(rope[j-1])) temp = p;
          }

          rope[j] = temp;
        }
      }

      record.add(Point.clone(rope.last));
    }
  }

  return record.length;
}

(String, int) process(String line) {
  List<String> temp = line.split(' ');

  return (temp[0], int.parse(temp[1]));
}

class Point {
  int x, y;

  Point(this.x, this.y);
  Point.clone(Point p) : this(p.x, p.y);

  static final Point origin = Point(0, 0);

  List<Point> get adjs => [
    Point(-1, -1),
    Point(-1, 0),
    Point(-1, 1),
    Point(0, 1),
    Point(1, 1),
    Point(1, 0),
    Point(1, -1),
    Point(0, -1),
  ].map((p) => p + this).toList();

  void step(String dir) {
    switch (dir) {
      case 'U': this.y += 1;
      case 'D': this.y -= 1;
      case 'R': this.x += 1;
      case 'L': this.x -= 1;
    }
  }

  int mDist(Point other) {
    return (this.x - other.x).abs() + (this.y - other.y).abs();
  }

  @override
  bool operator ==(Object o) {
    return o is Point && this.x == o.x && this.y == o.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  Point operator +(Point other) => Point(this.x + other.x, this.y + other.y);

  @override
  String toString() => 'Point($x, $y)';
}