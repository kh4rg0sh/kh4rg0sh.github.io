---
linkTitle: Bigger is Better
title: Bigger is Better [Writeup]
type: docs
math: True
weight: 2
---
## Challenge Description

> In the world of encryption, let me tell you, bigger is better, folks. When you're talking about RSA, you want an exponent that's huge, believe me. Some people say, "Oh, go small for efficiency." But I say, forget about efficiency, we're talking about security! With a big exponent, you're going to have the best security, nobody's going to crack it, nobody! So, remember: go big or go home, and you'll be winning bigly in cybersecurity!

## Challenge Files
```py {filename=gen.py, linenos=table}
import os
import gmpy2
import Crypto.Util.number as number
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP

def gen_params():
    e = gmpy2.mpz(number.getPrime(520))
    while True:
        while True:
            p = gmpy2.mpz(number.getPrime(512))
            q = (p * gmpy2.invert(p - 1, e)) % e
            if q.is_prime():
                break

        n = p * q
        phi = (p-1)*(q-1)

        if gmpy2.gcd(e, phi) == 1 and e < phi:
            d = (1 + (e - 1) * phi) // e
            return (int(n), int(e), int(d))
        
flag = os.environ["FLAG"]
key = RSA.construct(gen_params())

cipher = PKCS1_OAEP.new(key)
ciphertext = cipher.encrypt(flag.encode())

print("Flag:", ciphertext.hex())
print("n:", key.n)
print("e:", key.e)
```
```txt {filename=out.txt, linenos=table}
Flag: 01b61a99ec3144e1eb15dd819185c340c7b17b38d069f5189807681d3c7a26afe1088f6b270c9cf26915d857e83de910971054fb92926adb0226325317510ddc5129a21beb6241001e638f6981cbcb3cd5a0be8168ae21d149d83fd3e9b5f9115e28ab2320a201a522d25f4e14552434835af1bb22d3f710341ed22722011c0372
n: 597335689226045056913166505037840157078954264999700629833258496762227084400401604912493527516646939874075386574739856551056864389324619848840266776702144772354597990152158599522528018659755118263808518976172810917606196554528503935276695298154816588160752930883134894518555210481664717173645960866565960880557
e: 2634065751614482329107725637023560471652100411843894146340117230337954286149474325215157995353348215193206597222786188634557304190252766656287157923889937903
```

## Solution 
To begin with, let's analyse the given cryptosystem. The very evident vulnerability we have lies on `Line 12`. The primes `p` and `q` chosen for the RSA cryptosystem are not independent which implies that we have an additional information about the given parameters. We could play with the relation as follows 

$$ 
    q \equiv \frac{p}{p - 1} \pmod{e} \implies N \equiv p + q \pmod{e} 
$$

Since we know the parameter $N$ and $e$ is significantly larger than $p$, therefore we could safely assume the above congruency to be an equality! In conclusion, we have demonstrated that the additional information provides us with the value of `(p + q)`. This is not only sufficient to compute the euler totient function of $N$, but also sufficient to leak $p$ and $q$.

### Solve Script
```py
from sage.all import *
from Crypto.Util.number import *
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP

Flag =  0x01b61a99ec3144e1eb15dd819185c340c7b17b38d069f5189807681d3c7a26afe1088f6b270c9cf26915d857e83de910971054fb92926adb0226325317510ddc5129a21beb6241001e638f6981cbcb3cd5a0be8168ae21d149d83fd3e9b5f9115e28ab2320a201a522d25f4e14552434835af1bb22d3f710341ed22722011c0372
n =  597335689226045056913166505037840157078954264999700629833258496762227084400401604912493527516646939874075386574739856551056864389324619848840266776702144772354597990152158599522528018659755118263808518976172810917606196554528503935276695298154816588160752930883134894518555210481664717173645960866565960880557
e = 2634065751614482329107725637023560471652100411843894146340117230337954286149474325215157995353348215193206597222786188634557304190252766656287157923889937903

def sqrt(y):
    l = 1
    r = 10 ** (3000)
    while l < r:
        mid = (l + r) >> 1 
        if mid * mid > y:
            r = mid - 1
        elif mid * mid < y:
            l = mid + 1
        else:
            l = mid
            r = mid 
            break 
    return l

x = (n % e)
p = (x + sqrt(x ** 2 - 4 * n)) // 2
q = n // p

phi = n - x + 1

d = pow(e, -1, phi) 

print(p)
print(q)

key = RSA.construct((n, e, d, p, q))
cipher = PKCS1_OAEP.new(key)

print(cipher.decrypt(long_to_bytes(Flag)))

## CSR{e_g0e5_brrrrrrrr}
```

## Flag
```
CSR{e_g0e5_brrrrrrrr}
```
