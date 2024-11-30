#!/usr/bin/env python3

import sys
from collections import Counter

z = [] # binaar ise
n = [] # failinimi
p = [] # populaarsustabel

for arg in sys.argv[1:]:
    with open(arg, 'rb') as binfile:
        z.append(binfile.read())
        n.append(arg)

outbin = open(n[0]+"_agreed.bin", "wb")
l = len(z)
for i in range(len(z[0])):
    v = [x[i] for x in z]
    c = Counter(v)
    m = c.most_common()
    if len(m)>1:
        print(f"{i:04X}: ", end="")
        for x in m:
            #print(f"{x[0]:08b}", c[x[0]], end=" ") # bin
            print(f"{x[0]:02X}", c[x[0]], end=" ") # hex
        for x in m:
            print ("\t| ", end="")
            for j in range(len(v)):
                if v[j] == x[0]:
                    print(n[j][-1], end=" ") # failinime viimane tärk
                    # kui konkreetne on levinuim, siis lisa populaarsustabelisse
                    # (välista, kui esikoht on jagamisel)
                    if x[0] == m[0][0] and m[0][1]!=m[1][1]:
                        p.append(n[j][-1])
        # esikoht on jagamisel
        if m[0][1]==m[1][1]: print(" 🙈")
        else:
            print()
    outbin.write(bytes([m[0][0]]))

print(", ".join("`{}` -- {}".format(*x) for x in Counter(p).most_common()))
