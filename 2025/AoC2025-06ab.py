from functools import reduce

def transpose[T](arr: list[list[T]]) -> list[list[T]]:
  for row in arr: assert(len(row) == len(arr[0]))

  out = []
  for j in range(len(arr[0])):
    out.append(list(map(lambda row: row[j], arr)))

  return out

def calc(nums: list[list[int]], signs: list[str]) -> int:
  total = 0
  for n, s in zip(nums, signs):
    match s:
      case '+':
        total += reduce(lambda acc, v: acc + v, n, 0)
      case '*':
        total += reduce(lambda acc, v: acc * v, n, 1)
      case _: sys.exit(1)

  return total

lines = [line.rstrip('\n') for line in open("input.txt", "r").readlines()]

nums1 = transpose([list(map(lambda s: int(s), line.split())) for line in lines[:-1]])

nums2 = [[]]
for line in map(lambda line: ''.join(line).strip(), transpose([list(line) for line in lines[:-1]])):
  if line: nums2[-1].append(int(line))
  else: nums2.append([])

signs = lines[-1].split()
for s in signs: assert(s in "+*")

assert(len(nums1) == len(nums2))
assert(len(nums1) == len(signs))

print("Part 1 answer:", calc(nums1, signs))
print("Part 2 answer:", calc(nums2, signs))