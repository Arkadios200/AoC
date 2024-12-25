import hashlib

i = 0
input = "abc"
code1 = ""
code2 = [" ", " ", " ", " ", " ", " ", " ", " "]
while (len(code1) < 8 or " " in code2):
  string = input + str(i)
  result = hashlib.md5(string.encode()).hexdigest()
  if result[0:5] == "00000":
    if len(code1) < 8:
      code1 += result[5]

    if result[5] >= "0" and result[5] <= "7":
      if code2[int(result[5])] == " ":
        code2[int(result[5])] = result[6]
  
  i += 1

print(code1)
print("".join(code2))
