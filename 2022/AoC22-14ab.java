import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Objects;

public class Main {
  public static void main(String[] args) {
    Set<Point> walls = getInput();

    System.out.printf("Part 1 answer: %d\n", part1(walls));
    System.out.printf("Part 2 answer: %d", part2(walls));
  }

  static int part1(Set<Point> walls) {
    Set<Point> record = new HashSet<>();

    int bottom = 0;
    for (final Point p : walls) {
      if (bottom < p.y) bottom = p.y;
    }

    while (true) {
      Point sand = new Point(Point.newSand);
      while (true) {
        if (sand.y > bottom) return record.size();

        Point nextPoint = null;
        for (int n : new int[] { 0, -1, 1 }) {
          Point p = sand.add(new Point(n, 1));
          if (!record.contains(p) && !walls.contains(p)) {
            nextPoint = p;
            break;
          }
        }

        if (nextPoint != null) sand = nextPoint;
        else {
          record.add(sand);
          break;
        }
      }
    }
  }

  static int part2(Set<Point> walls) {
    Set<Point> record = new HashSet<>();

    int bottom = 0;
    for (final Point p : walls) {
      if (bottom < p.y) bottom = p.y;
    }
    bottom += 1;

    while (!record.contains(Point.newSand)) {
      Point sand = new Point(Point.newSand);
      while (true) {
        if (sand.y == bottom) break;

        Point nextPoint = null;
        for (int n : new int[] { 0, -1, 1 }) {
          Point p = sand.add(new Point(n, 1));
          if (!record.contains(p) && !walls.contains(p)) {
            nextPoint = p;
            break;
          }
        }

        if (nextPoint != null) sand = nextPoint;
        else break;
      }

      record.add(sand);
    }

    return record.size();
  }

  static Set<Point> getInput() {
    Set<Point> walls = new HashSet<>();
    Scanner sc = new Scanner(System.in);
    while (sc.hasNextLine()) {
      List<Point> points = new ArrayList<>();
      for (final String s : sc.nextLine().split(" -> ")) {
        String[] nums = s.split(",", 2);
        points.add(new Point(Integer.parseInt(nums[0]), Integer.parseInt(nums[1])));
      }

      for (final Pair<Point, Point> p : tupleWindows(points)) {
        Point a = p.a;
        Point b = p.b;

        if (a.x != b.x) {
          for (int x = Math.min(a.x, b.x); x <= Math.max(a.x, b.x); x++) {
            walls.add(new Point(x, a.y));
          }
        } else if (a.y != b.y) {
          for (int y = Math.min(a.y, b.y); y <= Math.max(a.y, b.y); y++) {
            walls.add(new Point(a.x, y));
          }
        } else throw new RuntimeException();
      }
    }

    sc.close();

    return walls;
  }

  static <A, B> List<Pair<A, B>> zip(List<A> a, List<B> b) {
    int l = Math.min(a.size(), b.size());

    List<Pair<A, B>> out = new ArrayList<>(l);
    for (int i = 0; i < l; i++) {
      out.add(new Pair<>(a.get(i), b.get(i)));
    }

    return out;
  }

  static <T> List<Pair<T, T>> tupleWindows(List<T> l) {
    return zip(l, l.subList(1, l.size()));
  }
}

class Point {
  public final int x;
  public final int y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(Point p) {
    this.x = p.x;
    this.y = p.y;
  }

  public Point add(Point other) {
    return new Point(this.x + other.x, this.y + other.y);
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

  public static final Point newSand = new Point(500, 0);
}

class Pair<A, B> {
  public final A a;
  public final B b;

  public Pair(A a, B b) {
    this.a = a;
    this.b = b;
  }
}