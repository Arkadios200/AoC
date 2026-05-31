import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Objects;

public class Main {
  public static void main(String[] args) {
    List<Pair<Character, Integer>> dirs = getInput();

    System.out.printf("Part 1 answer: %d\n", part1(dirs));
    System.out.printf("Part 2 answer: %d\n", part2(dirs));
  }

  static int part1(List<Pair<Character, Integer>> dirs) {
    Nav nav = new Nav(new Point(0, 0), 0);
    for (Pair<Character, Integer> p : dirs) {
      char dir = p.a;
      int dist = p.b;

      nav.turn(dir);
      nav.step(dist);
    }

    return nav.pos.mDist();
  }

  static int part2(List<Pair<Character, Integer>> dirs) {
    Set<Point> record = new HashSet<>();
    record.add(new Point(0, 0));

    Nav nav = new Nav(new Point(0, 0), 0);
    while (true) {
      for (Pair<Character, Integer> p : dirs) {
        char dir = p.a;
        int dist = p.b;

        nav.turn(dir);
        for (int i = 0; i < dist; i++) {
          if (!record.add(nav.step(1))) return nav.pos.mDist();
        }
      }
    }
  }

  static List<Pair<Character, Integer>> getInput() {
    Scanner sc = new Scanner(System.in);
    String input = sc.nextLine();
    sc.close();

    List<Pair<Character, Integer>> dirs = new ArrayList<>();
    for (String line : input.split(", ")) {
      char dir = line.charAt(0);
      int dist = Integer.parseInt(line.substring(1));
      dirs.add(new Pair<>(dir, dist));
    }

    return dirs;
  }
}

class Point {
  int x, y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(Point p) {
    this(p.x, p.y);
  }

  public int mDist(Point other) {
    return Math.abs(this.x - other.x) + Math.abs(this.y - other.y);
  }

  public int mDist() {
    return Math.abs(x) + Math.abs(y);
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
}

class Nav {
  Point pos;
  int dir;

  public Nav(Point pos, int dir) {
    this.pos = pos;
    this.dir = dir;
  }

  public void turn(char d) {
    switch (d) {
    case 'L':
      dir = (dir + 3) % 4;
      break;
    case 'R':
      dir = (dir + 1) % 4;
      break;
    default: throw new RuntimeException("Invalid direction");
    }
  }

  public Point step(int dist) {
    switch (dir) {
      case 0:
        this.pos.y += dist;
        break;
      case 1:
        this.pos.x -= dist;
        break;
      case 2:
        this.pos.y -= dist;
        break;
      case 3:
        this.pos.x += dist;
        break;
      default:
        throw new RuntimeException("Invalid direction");
    }

    return new Point(this.pos);
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