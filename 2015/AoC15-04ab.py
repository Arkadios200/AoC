import hashlib

found1 = False
found2 = False
i = 0
while (not (found1 and found2)):
  temp = hashlib.md5(("yzbqklnj" + str(i)).encode()).hexdigest()
  
  if temp[0:5] == "00000" and not found1:
    print(f"Part 1 answer: {i}")
    found1 = True
    
  if temp[0:6] == "000000" and not found2:
    print(f"Part 2 answer: {i}")
    found2 = True

  i += 1
