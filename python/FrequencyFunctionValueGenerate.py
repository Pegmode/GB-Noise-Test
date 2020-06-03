#generate full lookup table to pass values into game boy noise register 43

class SContainer():
  def __init__(self,val,s,r):
    self.val = val
    self.s = s
    self.r = r


def fcn(s,r):
  if r == 0:
    r = 0.5
  return (524288)/(r*2**(s+1))

tts = []

for i in range(14):
  for j in range(8):
    #print("s{1} r{2} \n   {0:.0f}".format(fcn(i,j),i,j))
    tts.append(SContainer(fcn(i,j),i,j))

tts.sort(key=lambda x:x.val,reverse=True)
tts.reverse()
for stuff in tts:
  print("s{1} r{2} \n   {0:.0f}".format(stuff.val,stuff.s,stuff.r))

print("\n\n\n\nSIZE {}".format(len(tts)))

opstring15 = ";15 Step\ndb"
opstring7 = ";7 Step\ndb"

for entry in tts:

  temp = entry.s << 4
  temp = temp | entry.r
  opstring15 += " ${}, ".format(hex(temp)[2:]) 
  temp = temp | 8
  opstring7 += " ${}, ".format(hex(temp)[2:]) 

  opstring15 = opstring15
  opstring7 = opstring7


f = open("noiseTable.asm","w")
f.write(opstring15[:-2])
f.write("\n")
f.write(opstring7[:-2])
f.close()

