import java.util.List;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
  public static void main(String[] args) {
    String input = getInput();

    System.out.println(part1(input));
    System.out.println(knotHash(input));
  }

  static int part1(String input) {
    List<Integer> dirs = new ArrayList<>();
    for (String s : input.split(",")) dirs.add(Integer.parseInt(s));

    final int len = 256;
    Integer[] nums = new Integer[len];
    for (int i = 0; i < len; i++) nums[i] = i;

    int skip = 0;
    int i = 0;
    for (int n : dirs) {
      for (int a = 0; a < n/2; a++) {
        int w = (i + a) & len-1;
        int x = (i + n - a - 1) & len-1;

        swap(nums, w, x);
      }

      i = i + n + skip++;
    }

    return nums[0] * nums[1];
  }

  static String knotHash(String input) {
    List<Integer> dirs = new ArrayList<>();
    for (char c : input.toCharArray()) dirs.add((int) c);
    for (int n : new int[] { 17, 31, 73, 47, 23 }) dirs.add(n);

    final int len = 256;
    Integer[] nums = new Integer[len];
    for (int i = 0; i < len; i++) nums[i] = i;

    int skip = 0;
    int i = 0;
    for (int loop = 1; loop <= 64; loop++) {
      for (int n : dirs) {
        for (int a = 0; a < n/2; a++) {
          int w = (i + a) & len-1;
          int x = (i + n - a - 1) & len-1;

          swap(nums, w, x);
        }

        i = i + n + skip++;
      }
    }

    StringBuilder out = new StringBuilder(32);
    for (int j = 0; j < len; j += 16) {
      int temp = 0;
      for (int k = j; k < j+16; k++) temp ^= nums[k];

      out.append(String.format("%02x", temp));
    }

    return out.toString();
  }

  static <T> void swap(T[] v, int a, int b) {
    T temp = v[a];
    v[a] = v[b];
    v[b] = temp;
  }

  static String getInput() {
    Scanner sc = new Scanner(System.in);
    String input = sc.nextLine();
    sc.close();

    return input;
  }
}