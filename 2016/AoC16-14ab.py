import hashlib
import re
from typing import Callable

def hasher1(s: str) -> str:
  return hashlib.md5(s.encode()).hexdigest()

def hasher2(s: str) -> str:
  t = hashlib.md5(s.encode()).hexdigest()
  for j in range(2016):
    t = hashlib.md5(t.encode()).hexdigest()

  return t

def calc(salt: str, hasher: Callable[[str], str]):
  n = -1
  memo: dict[int, str] = dict()

  for i in range(64):
    while True:
      n += 1
      if n not in memo:
        memo[n] = hasher(salt + str(n))

      m = re.search(r'([0-9a-f])\1\1+', memo[n])
      if m == None: continue
      digit = m.group()[0]

      cond = False
      for j in range(n+1, n+1001):
        if j not in memo:
          memo[j] = hasher(salt + str(j))

        if digit not in memo[j]: continue
        if re.search(rf'({digit})\1\1\1\1+', memo[j]) != None:
          cond = True
          break

      if cond: break

  return n

salt = 'abc'
print('Part 1 answer:', calc(salt, hasher1))
print('Part 2 answer:', calc(salt, hasher2))