---
title: The Branch and Prune technique
date: 2023-09-08 00:00:00 +0530
categories: [CTF]
tags: [cryptography]
math: true
---

today i'll be discussing a really useful implementation heavy technique that leads to bit by bit leakage of information of variables when provided some extra informations. the best way to demonstrate is through examples so let's get started

## XORSA [PlaidCTF 2021]

a typical RSA challenge that provides you the information of $n,e,c$ and along with that the information $p \oplus q$. it turns out that an RSA system with $p\oplus q$ and $p\times q$ publically known is cryptographically insecure

### Solution

the idea is that we could leak the bits of the primes $p$ and $q$ one by one starting from the LSB (least significant bit). since in this case $p$ and $q$ are odd, we already know their LSB's, that is $1$. suppose we are at the $i$th bit from the left and we have figured out all the bits $p_k$ and $q_k$ for $k<i$, then there are four possible cases for each such valid number that we've found yet. our strategy would be to check if in any of these four cases we could extend our found solution from $i-1$ to $i$. we perform this recursively $\log N$ times to solve for $p$ and $q$. here's an implementation

```python
from Cryptodome.Util.number import *

n = # insert p*q here
r = # insert p xor q here

tracked = [(1,1)]
l = int(ceil(log(n, 2)/2))
dp = [(0,0), (0,1), (1,0), (1,1)]
for i in range(1,l+1):
    new_tracked = []
    for p,q in tracked:
        for (pi,qi) in dp:
            px = p + pi*(1<<i)
            qx = q + qi*(1<<i)
            px &= (1<<(i+1))-1
            qx &= (1<<(i+1))-1
            nx = n&((1<<(i+1))-1)
            rx = r&((1<<(i+1))-1)
            px,qx = sorted([px,qx])
            if (px*qx)&((1<<(i+1))-1)==nx and px^qx==rx and (px,qx) not in new_tracked:
                new_tracked.append((px,qx))
    tracked = new_tracked
new_tracked = []
for p,q in tracked:
    if p*q==n and p^q==r:
        new_tracked.append((p,q))
print(new_tracked)
```

this algorithm solves the given problem at hand easily.

## Fusion [WaniCTF 2023]

another RSA problem where we are again told about $n$,$e$ and $c$ and the extra information provided to us this time is the information about the odd-positioned bits of $p$ and the even-positioned bits of $q$. turns out that this system is still cryptographically insecure.

### Solution

the idea is similar to the previous ones. we need to leak off bit by bit information about the two primes $p$ and $q$. since we already know that they are odd primes, we already know about their LSB's. we have to tweak the above algorithm and it would leak off the entire information about the bits of the primes $p$ and $q$ one by one.

the algorithm works as follows. suppose we are the $i$th position and we need to determine the $i$th bits of $p$ and $q$. if $i$ is even, we know the information about $q_i$ and if $i$ is odd, then we know the information about $p_i$. in each case, we need to check for two cases and propogate the answers from the previous case to the next ones using bit masking.

```python
from Cryptodome.Util.number import *
from math import ceil,log2

n = 27827431791848080510562137781647062324705519074578573542080709104213290885384138112622589204213039784586739531100900121818773231746353628701496871262808779177634066307811340728596967443136248066021733132197733950698309054408992256119278475934840426097782450035074949407003770020982281271016621089217842433829236239812065860591373247969334485969558679735740571326071758317172261557282013095697983483074361658192130930535327572516432407351968014347094777815311598324897654188279810868213771660240365442631965923595072542164009330360016248531635617943805455233362064406931834698027641363345541747316319322362708173430359
e = 65537
c = 887926220667968890879323993322751057453505329282464121192166661668652988472392200833617263356802400786530829198630338132461040854817240045862231163192066406864853778440878582265466417227185832620254137042793856626244988925048088111119004607890025763414508753895225492623193311559922084796417413460281461365304057774060057555727153509262542834065135887011058656162069317322056106544821682305831737729496650051318517028889255487115139500943568231274002663378391765162497239270806776752479703679390618212766047550742574483461059727193901578391568568448774297557525118817107928003001667639915132073895805521242644001132
r = 163104269992791295067767008325597264071947458742400688173529362951284000168497975807685789656545622164680196654779928766806798485048740155505566331845589263626813345997348999250857394231703013905659296268991584448212774337704919390397516784976219511463415022562211148136000912563325229529692182027300627232945

l = max(len(bin(r)[2:]),int(ceil(log2(n))+1))
tracked = [(1,1)]
for i in range(1,l):
    new_tracked = []
    for (p,q) in tracked:
        if i%2:
            q0 = q + (r&(1<<i))
            for j in range(2):
                px = p + j*(1<<i)
                qx = q0
                px &= (1<<(i+1))-1
                qx &= (1<<(i+1))-1
                nx = n&((1<<(i+1))-1)
                if (px*qx)&((1<<(i+1))-1) == nx and (px,qx) not in new_tracked:
                    new_tracked.append((px,qx))
        else:
            p0 = p + (r&(1<<i))
            for j in range(2):
                qx = q + j*(1<<i)
                px = p0
                px &= (1<<(i+1))-1
                qx &= (1<<(i+1))-1
                nx = n&((1<<(i+1))-1)
                if (px*qx)&((1<<(i+1))-1) == nx and (px,qx) not in new_tracked:
                    new_tracked.append((px,qx))
    tracked = new_tracked
new_tracked = []
for (p,q) in tracked:
    if p*q == n:
        new_tracked.append((p,q))
for (p,q) in new_tracked:
    print(long_to_bytes(pow(c,pow(e,-1,(p-1)*(q-1)),n)))
```

running this script we get our flag: `FLAG{sequ4ntia1_prim4_fact0rizati0n}`
