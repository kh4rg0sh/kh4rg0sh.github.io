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
from math import ceil,log2
n = # insert p*q here
r = # insert p xor q here

tracked = [(1,1)]
l = int(ceil(log2(n, 2)/2))
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

another RSA problem where we are again told about $n$, $e$ and $c$ and the extra information provided to us this time is the information about the odd-positioned bits of $p$ and the even-positioned bits of $q$. turns out that this system is still cryptographically insecure.

### Solution

the idea is similar to the previous ones. we need to leak off bit by bit information about the two primes $p$ and $q$. since we already know that they are odd primes, we already know about their LSB's. we have to tweak the above algorithm and it would leak off the entire information about the bits of the primes $p$ and $q$ one by one.

the algorithm works as follows. suppose we are the $i$th position and we need to determine the $i$th bits of $p$ and $q$. if $i$ is even, we know the information about $q_i$ and if $i$ is odd, then we know the information about $p_i$. in each case, we need to check for two cases and propogate the answers from the previous case to the next ones using bit masking.

```python
from Cryptodome.Util.number import *
from math import ceil,log2

n = #
e = #
c = #
r = #

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

now i could have ended this here, but this is where things start getting more interesting! it turns out that you need not write out a whole brute script from scratch to prune over the bits and solve for $p$ and $q$. you can instead just use a z3solver to do that for us. lets solve the above challenge using a z3solver. here's my script that works great 

```python
from z3 import *
from Crypto.Util.number import *

n = #
e = #
c = #
r = #

bitlen = 1024

P = BitVec('p', bitlen)
Q = BitVec('q', bitlen)

mask = int("55" * 128, 16)
# r = p & mask
# mask = mask << 1
# r += q & mask

solver = Solver()
solver.add(P * Q == n)
solver.add(((P & mask) + (Q & (mask << 1))) == r)

if (solver.check() == sat):
    M = solver.model()
    p = M[P].as_long()
    q = M[Q].as_long()

    phi = (p - 1) * (q - 1)
    d = pow(e, -1, phi)
    print(long_to_bytes(pow(c, d, n)))
```

sometimes it turns out that writing brute scripts from scratch becomes difficult and complicated, hence we rely on z3solver.


## Shibs [MapnaCTF 2024]
another rsa problem where we know $n$, $e$ and $c$. however we also know $p & q$ and we are given that $q$ is just $p[:s]$ $+$ $p[s:]$ for some random hidden $s$. 

### Solution

we'll do the same again. lets pump these all into the z3solver again and let it do the magic for us. since we also dont know the $s$, i'll brute over that too. here's my script

```python
from Crypto.Util.number import *
from z3 import *

n = #
r = #
enc = #

bitlen = 1024
e = #

for s in range(1, 1024):
    P = BitVec('p', bitlen)
    Q = BitVec('q', bitlen) 

    solver = Solver()
    solver.add(P * Q == n)
    solver.add(P & Q == r)
    shifted_P = Concat(Extract(bitlen - s - 1, 0, P), Extract(bitlen - 1, bitlen - s, P))
    solver.add(Q == shifted_P)

    if (solver.check() == sat):
        M = solver.model()
        print(M)
        p = M[P].as_long()
        q = M[Q].as_long()

        phi = (p - 1) * (q - 1)
        d = pow(e, -1, phi)
        print(long_to_bytes(pow(enc, d, p * q)))
        break
    else:
        print(s)
```
and this gives us our flag `MAPNA{Br4nch_&_prun3_Or_4Nother_ApprOacH???}`.  pretty cool trick aint it?