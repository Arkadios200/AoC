from functools import reduce
from operator import mul
from typing import Self, Callable

class Point:
  def __init__(self, x: int, y: int, z: int):
    self.x = x
    self.y = y
    self.z = z

  def __repr__(self) -> str:
    return f"Point({self.x}, {self.y}, {self.z})"

  def __eq__(self, other: Self) -> Self:
    t = type(self) == type(other)
    x = self.x == other.x
    y = self.y == other.y
    z = self.z == other.z

    return t and x and y and z

  def __hash__(self) -> int:
    return hash((self.x, self.y, self.z))

  def dist(self, other: Self) -> int:
    x = self.x - other.x
    y = self.y - other.y
    z = self.z - other.z

    return x * x + y * y + z * z

def unordered_pairs[T](l: list[T]) -> list[tuple[T, T]]:
  return [(l[i], item) for i in range(len(l)-1) for item in l[i+1:]]

def index_where[T](cond: Callable[[T], bool], l: list[T]) -> int:
  for i, e in enumerate(l):
    if cond(e): return i

  raise ValueError("No item satisfying predicate found")

def process(line: str) -> Point:
  temp = [int(s) for s in line.split(",", 2)]
  return Point(temp[0], temp[1], temp[2])

def part1(points: list[Point]) -> int:
  circuits: list[set[Point]] = []
  for a, b in sorted(unordered_pairs(points), key=lambda p: p[0].dist(p[1]))[:1000]:
    try: i = index_where(lambda c: a in c, circuits)
    except: i = None
    try: j = index_where(lambda c: b in c, circuits)
    except: j = None

    if i is not None and j is not None:
      if i == j: continue
      circuits[min(i, j)].update(circuits.pop(max(i, j)))
    elif i is not None: circuits[i].add(b)
    elif j is not None: circuits[j].add(a)
    else: circuits.append({a, b})

  return reduce(mul, sorted(map(len, circuits), reverse=True)[:3])

def part2(points: list[Point]) -> int:
  circuits: list[set[Point]] = []
  count = 0
  for a, b in sorted(unordered_pairs(points), key=lambda p: p[0].dist(p[1])):
    try: i = index_where(lambda c: a in c, circuits)
    except: i = None
    try: j = index_where(lambda c: b in c, circuits)
    except: j = None

    if i is not None and j is not None:
      if i == j: continue
      circuits[min(i, j)].update(circuits.pop(max(i, j)))
    elif i is not None:
      circuits[i].add(b)
      count += 1
    elif j is not None:
      circuits[j].add(a)
      count += 1
    else:
      circuits.append({a, b})
      count += 2

    if count == len(points): return a.x * b.x

  # Unreachable
  sys.exit(1)

with open("input.txt", "r") as f:
  points = [process(line.strip()) for line in f.readlines()]

print("Part 1 answer:", part1(points))
print("Part 2 answer:", part2(points))