import 'dart:io';

const int WIDTH = 101;
const int HEIGHT = 103;

void main() {
  final String input = File('input.txt').readAsStringSync();
  List<Robot> robots = input.lines.map(process).toList();

  print('Part 1 answer: ${part1(robots.clone())}');
  print('Part 2 answer: ${part2(robots.clone())}');
}

int part1(List<Robot> robots) {
  for (Robot r in robots) r.step(100);

  final int midX = WIDTH ~/ 2;
  final int midY = HEIGHT ~/ 2;
  
  return <bool Function(Robot)>[
    (r) => r.pos.x < midX && r.pos.y < midY,
    (r) => r.pos.x < midX && r.pos.y > midY,
    (r) => r.pos.x > midX && r.pos.y < midY,
    (r) => r.pos.x > midX && r.pos.y > midY,
  ].fold<int>(1, (acc, v) => acc * robots.where(v).length);
}

int part2(List<Robot> robots) {
  int i = 0;
  while (true) {
    i += 1;

    for (Robot r in robots) r.step();
    if (Set.of(robots).length == robots.length) return i;
  }
}

Robot process(String line) {
  List<int> temp = line
    .split(RegExp(r'[^\d|\-]+'))
    .where((s) => s.isNotEmpty)
    .map(int.parse)
    .toList();
  if (temp.length != 4) exit(1);

  return Robot(Point(temp[0], temp[1]), Point(temp[2], temp[3]));
}

class Point {
  int x, y;

  Point(this.x, this.y);
  Point.clone(Point p) : this(p.x, p.y);

  Point operator +(Point other) =>
    Point(this.x + other.x, this.y + other.y);

  Point operator *(int n) =>
    Point(this.x * n, this.y * n);

  Point operator %(Point other) =>
    Point(this.x % other.x, this.y % other.y);

  @override
  bool operator ==(Object other) =>
    other is Point && this.x == other.x && this.y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

class Robot {
  Point pos;
  Point vel;

  Robot(this.pos, this.vel);
  Robot.clone(Robot r) : this(Point.clone(r.pos), Point.clone(r.vel));

  void step([int time = 1]) {
    this.pos += (this.vel * time);
    this.pos %= Point(WIDTH, HEIGHT);
  }

  @override
  bool operator ==(Object other) =>
    other is Robot && this.pos == other.pos;

  @override
  int get hashCode => pos.hashCode;
}

extension on String {
  Iterable<String> get lines => this.split('\n');
}

extension <E> on List<E> {
  List<E> clone() => List.generate(this.length, (i) => this[i]);
}