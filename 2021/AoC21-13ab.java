import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Objects;
import java.util.Arrays;

public class Main {
  public static void main(String[] args) {
    Pair<List<Point>, List<Pair<Character, Integer>>> input = getInput();
    List<Point> points = input.a;
    List<Pair<Character, Integer>> dirs = input.b;

    System.out.printf("Part 1 answer: %d\n", part1(points, dirs.get(0)));
    System.out.printf("Part 2 answer:\n%s\n", part2(points, dirs));
  }

  static int part1(List<Point> points, Pair<Character, Integer> dir) {
    return fold(new ArrayList<>(points), dir).size();
  }

  static String part2(List<Point> points, List<Pair<Character, Integer>> dirs) {
    List<Point> temp = new ArrayList<>(points);

    for (Pair<Character, Integer> dir : dirs) {
      temp = fold(temp, dir);
    }

    return layout(temp);
  }

  static List<Point> fold(List<Point> points, Pair<Character, Integer> dir) {
    char axis = dir.a;
    int coord = dir.b;

    Set<Point> temp = new HashSet<>();
    switch (axis) {
      case 'x':
        for (Point p : points) {
          temp.add(new Point(p.x > coord ? 2 * coord - p.x : p.x, p.y));
        }
        break;
      case 'y':
        for (Point p : points) {
          temp.add(new Point(p.x, p.y > coord ? 2 * coord - p.y : p.y));
        }
        break;
      default: throw new RuntimeException(String.format("Invalid input: %c", axis));
    }

    return new ArrayList<>(temp);
  }

  static String layout(List<Point> points) {
    int maxX = 0;
    int maxY = 0;
    for (Point p : points) {
      if (maxX <= p.x) maxX = p.x + 1;
      if (maxY <= p.y) maxY = p.y + 1;
    }

    char[][] grid = new char[maxY][maxX];
    for (char[] line : grid) Arrays.fill(line, ' ');

    for (Point p : points) grid[p.y][p.x] = '█';

    String[] layout = new String[grid.length];
    for (int i = 0; i < grid.length; i++) layout[i] = new String(grid[i]);

    return String.join("\n", layout);
  }

  static Pair<List<Point>, List<Pair<Character, Integer>>> getInput() {
    Scanner sc = new Scanner(System.in);
    List<Point> points = new ArrayList<>();
    while (sc.hasNextLine()) {
      String line = sc.nextLine();
      if (line.isEmpty()) break;

      int[] nums = new int[2];
      String[] substrs = line.split(",");
      if (substrs.length != 2) throw new RuntimeException(String.format("Invalid input: %s", line));
      for (int i = 0; i < 2; i++) nums[i] = Integer.parseInt(substrs[i]);

      points.add(new Point(nums[0], nums[1]));
    }

    List<Pair<Character, Integer>> dirs = new ArrayList<>();
    while (sc.hasNextLine()) {
      String[] temp = sc.nextLine().split(" ");
      String s = temp[temp.length - 1];

      char axis = s.charAt(0);
      int coord = Integer.parseInt(s.substring(2));

      dirs.add(new Pair<>(axis, coord));
    }

    sc.close();

    return new Pair<>(points, dirs);
  }
}

class Point {
  public final int x, y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point(Point p) {
    this.x = p.x;
    this.y = p.y;
  }

  @Override
  public int hashCode() {
    return Objects.hash(x, y);
  }

  @Override
  public boolean equals(Object o) {
    if (o == this) return true;
    if (!(o instanceof Point)) return false;

    Point p = (Point) o;
    return this.x == p.x && this.y == p.y;
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