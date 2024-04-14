---
linkTitle: Choose the param
title: Choose the param [Writeup]
type: docs
math: True
---
## Challenge Description

```
I wounder why we need to specify parameter length in the spec...
```
## Challenge Files
```python 
#!/usr/bin/python3
from Crypto.Util.number import long_to_bytes, bytes_to_long, getPrime
import os
from secret import flag

padded_flag = os.urandom(200) + flag + os.urandom(200)
m = bytes_to_long(padded_flag)

def chal():
    print("""Choose your parameter
Enter the bit length of the prime!
I'll choose two prime of that length, and encrypt the flag using rsa.
Try decrypt the flag!    
""")
    while True:
        bits = input("Enter the bit length of your primes> ")
        try:
            bit_len = int(bits)
        except:
            print("please enter a valid intergar")
            continue

        p1 = getPrime(bit_len)
        p2 = getPrime(bit_len)

        n = p1 * p2
        e = 65537
        c = pow(m, e, n)
        print(f"n = {n:x}")
        print(f"e = {e:x}")
        print(f"c = {c:x}")

if __name__ == "__main__":
    chal()

```
## Solution
Since we are allowed to choose the size of the RSA parameters and we are allowed to use the encryption oracle as many times as we want, we could query for RSA of weaker security (for example `64 bits`) and combine these using the chinese remainder theorem. What follows is a textbook RSA attack where the public modulus is easily factorisable. Here's the exploit

```python
from pwn import *
from sage.all import *
from Crypto.Util.number import *

r = remote('gold.b01le.rs', 5001, level='DEBUG')

N = []
C = []
e = 65537

for i in range(40):
    r.recvuntil(b"Enter the bit length of your primes> ")
    r.sendline(b'64')

    n = int(r.recvline().strip().split(b'n = ')[1].decode(), 16)
    e = int(r.recvline().strip().split(b'e = ')[1].decode(), 16)
    c = int(r.recvline().strip().split(b'c = ')[1].decode(), 16)

    N.append(n)
    C.append(c)

from math import gcd
for i in range(len(N)):
    for j in range(len(N)):
        if i == j:
            continue
        if (gcd(N[i], N[j]) > 1):
            print("non-coprime modulus found!")

primes = []
for i in range(len(N)):
    p, q = factor(N[i])
    
    primes.append(p[0])
    primes.append(q[0])

m = crt(C, N)

phi = 1
for i in primes:
    phi = phi * (i - 1)

modulus = 1
for i in N:
    modulus = modulus * i

d = pow(e, -1, phi)
print(long_to_bytes(pow(int(m), d, modulus)))

## bctf{dont_let_the_user_choose_the_prime_length_>w<}
```

## Flag
```
bctf{dont_let_the_user_choose_the_prime_length_>w<}
```
