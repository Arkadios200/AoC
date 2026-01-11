import java.util.Scanner;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Objects;

public class Main {
  public static void main(String[] args) {
    List<Pair<Character, Integer>> input = getInput();

    System.out.printf("Part 1 answer: %d\n", calc(input, 2));
    System.out.printf("Part 2 answer: %d\n", calc(input, 10));
  }

  static int calc(List<Pair<Character, Integer>> input, int len) {
    Set<Point> record = new HashSet<>();
    List<Point> rope = new ArrayList<>(len);
    for (int i = 0; i < len; i++) rope.add(new Point(Point.origin));

    for (final Pair<Character, Integer> line : input) {
      char dir = line.a;
      int dist = line.b;

      for (int i = 0; i < dist; i++) {
        rope.get(0).step(dir);
        for (Pair<Integer, Pair<Point, Point>> item : enumerate(1, tupleWindows(rope))) {
          int j = item.a;
          Point a = item.b.a;
          Point b = item.b.b;

          if (Math.abs(a.x - b.x) > 1 || Math.abs(a.y - b.y) > 1) {
            Point temp = b;
            for (final Point p : temp.adjs()) {
              if (temp.mDist(a) > p.mDist(a)) temp = p;
            }

            rope.set(j, temp);
          }
        }

        record.add(new Point(lastIn(rope)));
      }
    }

    return record.size();
  }

  static List<Pair<Character, Integer>> getInput() {
    Scanner sc = new Scanner(System.in);

    List<Character> dirs = new ArrayList<>();
    List<Integer> dists = new ArrayList<>();
    while (sc.hasNextLine()) {
      String line = sc.nextLine();

      dirs.add(line.charAt(0));
      dists.add(Integer.parseInt(lastIn(Arrays.asList(line.split(" ", 2)))));
    }

    return zip(dirs, dists);
  }

  static <T> T lastIn(List<T> l) {
    return l.get(l.size() - 1);
  }

  static <T> List<Pair<Integer, T>> enumerate(int start, List<T> items) {
    List<Pair<Integer, T>> out = new ArrayList<>();
    for (int i = 0; i < items.size(); i++) {
      out.add(new Pair<>(start + i, items.get(i)));
    }

    return out;
  }

  static <A, B> List<Pair<A, B>> zip(List<A> a, List<B> b) {
    int l = Math.min(a.size(), b.size());

    List<Pair<A, B>> out = new ArrayList<>();
    for (int i = 0; i < l; i++) out.add(new Pair<>(a.get(i), b.get(i)));

    return out;
  }

  static <T> List<Pair<T, T>> tupleWindows(List<T> items) {
    return zip(items, items.subList(1, items.size()));
  }
}

class Point {
  int x, y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(Point p) {
    this.x = p.x;
    this.y = p.y;
  }

  public int mDist(Point other) {
    return Math.abs(this.x - other.x) + Math.abs(this.y - other.y);
  }

  public Point add(Point other) {
    return new Point(this.x + other.x, this.y + other.y);
  }

  public Point[] adjs() {
    Point[] out = new Point[] {
      new Point(-1, -1),
      new Point(-1, 0),
      new Point(-1, 1),
      new Point(0, 1),
      new Point(1, 1),
      new Point(1, 0),
      new Point(1, -1),
      new Point(0, -1),
    };

    for (int i = 0; i < out.length; i++) out[i] = out[i].add(this);

    return out;
  }

  public void step(char dir) {
    switch (dir) {
      case 'U':
        this.y += 1;
        break;
      case 'D':
        this.y -= 1;
        break;
      case 'R':
        this.x += 1;
        break;
      case 'L':
        this.x -= 1;
        break;
      default:
        throw new RuntimeException("Invalid input");
    }
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (!(o instanceof Point)) return false;

    Point other = (Point) o;

    return this.x == other.x && this.y == other.y;
  }

  @Override
  public int hashCode() {
    return Objects.hash(x, y);
  }

  static final Point origin = new Point(0, 0);
}

class Pair<A, B> {
  public final A a;
  public final B b;

  public Pair(A a, B b) {
    this.a = a;
    this.b = b;
  }
}