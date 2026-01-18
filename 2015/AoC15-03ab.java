import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.stream.Stream;
import java.util.stream.Collectors;
import java.util.Arrays;
import java.util.Objects;

public class Main {
  public static void main(String[] args) {
    List<Character> input = getInput();

    System.out.println(part1(input));
    System.out.println(calc(input, 2));
  }

  static int part1(List<Character> input) {
    Point pos = new Point(Point.origin);
    Set<Point> record = new HashSet<>();
    record.add(new Point(pos));

    for (char c : input) {
      record.add(pos.step(c));
    }

    return record.size();
  }

  static int calc(List<Character> input, int n) {
    List<Point> pos = new ArrayList<>(n);
    for (int i = 0; i < n; i++) pos.add(new Point(Point.origin));

    Set<Point> record = new HashSet<>();
    record.add(new Point(Point.origin));

    for (Pair<Integer, Character> p : enumerate(input)) {
      int i = p.a;
      char c = p.b;

      record.add(pos.get(i % n).step(c));
    }

    return record.size();
  }

  static List<Character> getInput() {
    Scanner sc = new Scanner(System.in);
    List<Character> out = sc.nextLine()
      .chars()
      .mapToObj((c) -> (char) c)
      .collect(Collectors.toList());

    sc.close();

    return out;
  }

  static <T> List<Pair<Integer, T>> enumerate(List<T> l) {
    List<Pair<Integer, T>> out = new ArrayList<>();
    for (int i = 0; i < l.size(); i++) {
      out.add(new Pair<>(i, l.get(i)));
    }

    return out;
  }
}

class Point {
  private int x, y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(Point p) {
    this.x = p.x;
    this.y = p.y;
  }

  public Point step(char dir) {
    switch (dir) {
      case '^':
        this.y += 1;
        break;
      case 'v':
        this.y -= 1;
        break;
      case '<':
        this.x += 1;
        break;
      case '>':
        this.x -= 1;
        break;
      default:
        throw new RuntimeException();
    }

    return new Point(this);
  }

  public static final Point origin = new Point(0, 0);

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (!(o instanceof Point)) return false;

    Point p = (Point) o;
    return this.x == p.x && this.y == p.y;
  }

  @Override
  public int hashCode() {
    return Objects.hash(x, y);
  }
}

class Pair<A, B> {
  public final A a;
  public final B b;

  public Pair(A a, B b) {
    this.a = a;
    this.b = b;
  }
}