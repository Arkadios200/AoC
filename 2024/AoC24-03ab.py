import re

def get_product(match):
  a = match.find('(')
  b = match.find(',')
  c = match.find(')')

  op1 = int(match[a+1:b])
  op2 = int(match[b+1:c])

  return op1 * op2

def part1(input):
  matches = re.findall("mul\(\d+,\d+\)", input)

  total = 0

  for match in matches:
    total += get_product(match)

  return total

def part2(input):
  matches = re.findall("mul\(\d+,\d+\)|do\(\)|don't\(\)", input)

  total = 0

  enabled = True
  for match in matches:
    match match:
      case "do()":
        enabled = True
      case "don't()":
        enabled = False
      case _:
        if enabled: total += get_product(match)

  return total

with open('input.txt', 'r') as file:
  input = file.read()

total1 = part1(input)
print(f"Part 1 answer: {total1}")

total2 = part2(input)
print(f"Part 2 answer: {total2}")
