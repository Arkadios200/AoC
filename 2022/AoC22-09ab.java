import java.util.Scanner;
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
    Point[] rope = new Point[len];
    for (int i = 0; i < len; i++) rope[i] = new Point(Point.origin);

    for (final Pair<Character, Integer> line : input) {
      char dir = line.a;
      int dist = line.b;

      for (int i = 0; i < dist; i++) {
        rope[0].step(dir);
        for (int j = 1; j < rope.length; j++) {
          if (Math.abs(rope[j].x - rope[j-1].x) > 1 || Math.abs(rope[j].y - rope[j-1].y) > 1) {
            Point temp = rope[j];
            for (final Point p : temp.adjs()) {
              if (temp.mDist(rope[j-1]) > p.mDist(rope[j-1])) temp = p;
            }

            rope[j] = temp;
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
      dists.add(Integer.parseInt(lastIn(line.split(" ", 2))));
    }

    return Pair.zip(dirs, dists);
  }

  static <T> T lastIn(T[] arr) {
    return arr[arr.length - 1];
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

  static <A, B> List<Pair<A, B>> zip(List<A> a, List<B> b) {
    int l = Math.min(a.size(), b.size());

    List<Pair<A, B>> out = new ArrayList<>();
    for (int i = 0; i < l; i++) out.add(new Pair<>(a.get(i), b.get(i)));

    return out;
  }
}