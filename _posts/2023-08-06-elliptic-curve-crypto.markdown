---
title: Exploiting an ECLCG (Elliptic Curve Linear Congruential Generator) vulnerability
date: 2023-08-06 00:00:00 +0530
categories: [CTF]
tags: [elliptic-curves]
math: true
---
i solved a cool problem taken from one of the ctfs that recently took place, and i feel like it deserves its own blogpost. so i'll be discussing the problem as well as i'll be presenting its walkthrough in this blogpost. here's the problem statement
## Problem 
```
So I was reading a paper a while ago and it was about ECLCGs... I think idk I skimmed the paper. ECLCGs are probably just LCGs with elliptic curves though.... right?
```
i'll attach the <a href="/ignore/player_files/chall.sage">sage file</a>
and the <a href="/ignore/player_files/out.txt">text file</a> for this challenge. before we dive into the solution, i'll quickly explain what the problem is actually about. so they have encrypted the flag using AES encryption in CBC mode using a key $k$ and an initialisation vector $iv$. we know the encrypted message and the $iv$ but we do not know the key $k$. the key $k$ is derived from the pseudo-random number generated using an LCG (linear congruential generator) defined on an elliptic curve whose modulus is known and two points on it are known. but we do not know the equation of the elliptic curve. we also know the two previously generated pseudo-random numbers using this LCG and we need to decrypt the encrypted message. 

### Solution
so how do we do this? clearly if we want to decrypt the encrypted message, we must know $k$. to know $k$ we must break the LCG in order to predict the next number. fortunately this is possible to do so. we first start by noticing the procedure for generating the prime modulus for the elliptic curve $E$
```python
def fun_prime(n): 
    while True:
        ps = 16
        p = 1
        for i in range(n//ps):
            p *= random_prime(2^ps)
        p += 1
        if is_prime(p):
            return p
```
okay, so the prime $p$ is not smooth. hence, we can evaluate discrete logarithms in the field $\mathbb{F}_p$ if we are required to using pohlig-hellman's algorithm. next we observe that since we know our elliptic curve has an equation

$$
y^2 \equiv x^3 + Ax + B \pmod{p}
$$

hence if we know any two points lying on this elliptic curve, we could easily solve for $A$ and $B$. and surprisingly we do, so we can write a code to solve for $A$ and $B$ using a bit of algebra

$$
y_0^2 = x_0^3 + Ax_0 + B \pmod{p} 
$$

and, 

$$
y_1^2 = x_1^3 + Ax_1 + B \pmod{p}
$$

hence, 

$$
\left( y_1^2 - y_0^2 \right) = \left( x_1^3 - x_0^3\right) + A(x_1-x_0) \pmod{p}
$$

$$
A =\left( \left( y_1^2 - y_0^2 \right) - \left( x_1^3 - x_0^3\right) \right) \times (x_1-x_0)^{-1} \pmod{p}
$$

and we could plug this value of $A$ back to solve for $B$.

```python
x0 = 2029673067800379268
y0 = 1814239535542268363
x1 = 602316613633809952
y1 = 1566131331572181793
p = 2525114415681006599

A = ((y1**2 -y0**2)-(x1**3-x0**3))*(pow(x1-x0,-1,p))%p
B = (y1**2 - x1**3 - A*x1)%p
```
so we know the equation of our elliptic curve $E$ now. using this we could easily calculate the generator of this elliptic curve. 
```python
from sage.all import *

x0 = 2029673067800379268
y0 = 1814239535542268363
x1 = 602316613633809952
y1 = 1566131331572181793
p = 2525114415681006599

A = ((y1**2 -y0**2)-(x1**3-x0**3))*(pow(x1-x0,-1,p))%p
B = (y1**2 - x1**3 - A*x1)%p
E = EllipticCurve(GF(p), [A,B])
print(E.gens()[0])
```
once we know the generator of the elliptic curve, we know the seed of our LCG. since we know the two points on the elliptic curve $E$. hence it's possible to solve for the unknowns of the LCG. 

$$
X_0 \equiv aG + B \pmod{p}
$$

$$
X_1 \equiv aX_0 +B \pmod{p}
$$

hence, we could substitude for $B$ using the first congruence in the second congruence to get

$$
X_1 \equiv aX_0 + X_0 - aG \pmod{p}
$$

$$
\left( X_1 - X_0\right) \equiv a \left( X_0 - G\right) \pmod{p}
$$

therefore to solve for $a$ we need to calculate the discrete logarithm of $(X_1-X_0)$ to the base $(X_0-G)$ which is possible to do because $p$ is not a smooth prime

```python
from sage.all import *

x0 = 2029673067800379268
y0 = 1814239535542268363
x1 = 602316613633809952
y1 = 1566131331572181793
p = 2525114415681006599

A = ((y1**2 -y0**2)-(x1**3-x0**3))*(pow(x1-x0,-1,p))%p
B = (y1**2 - x1**3 - A*x1)%p
E = EllipticCurve(GF(p), [A,B])

G = E.gens()[0]
X0 = E(x0,y0)
X1 = E(x1,y1)
a = discrete_log(X1-X0,X0-G,(X0-G).order(),operation='+')
print(a)
```

after this we are basically done because solving for $a$ gives you $b$ directly using 

$$
X_0 -aG \equiv b \pmod{p}
$$

and hence we could calculate $(aX_1+b \pmod{p})$ very easily. here's the script to get the decrypted message after that

```python
from sage.all import *

x0 = 2029673067800379268
y0 = 1814239535542268363
x1 = 602316613633809952
y1 = 1566131331572181793
p = 2525114415681006599

A = ((y1**2 -y0**2)-(x1**3-x0**3))*(pow(x1-x0,-1,p))%p
B = (y1**2 - x1**3 - A*x1)%p
E = EllipticCurve(GF(p), [A,B])

G = E.gens()[0]
X0 = E(x0,y0)
X1 = E(x1,y1)

a = 1283473618943750015
b = X0-a*G

v = int((a*(a*(a*G+b)+b)+b)[0])
from Cryptodome.Cipher import AES
from Cryptodome.Util.number import long_to_bytes as l2b
from Cryptodome.Util.Padding import pad, unpad
k = pad(l2b((v)**2), 16)
enc = bytes.fromhex("a490e177c3838c8f24d36be5ee10e0c9e244ac2e54cd306eddfb0d585d5f27535835fab1cd83d26a669e6c08096b58cc4cc4cb082f4534ce80fab16e21f119adc45a5f59d179ca3683b77a942e4cf4081e01d921a51ec3a3a48c13f850c04b80c997367739bbde0a5415ff921d77a6ef")
iv = bytes.fromhex("6959dbf6bf22344d452c3831a3b68897")
cipher = AES.new(k, AES.MODE_CBC, iv=iv)
print(cipher.decrypt(enc))

```
and this is the output
```
b'LITCTF{Youre_telling_me_I_cant_just_throw_elliptic_curves_on_something_and_make_it_100x_secure?_:<}\r\r\r\r\r\r\r\r\r\r\r\r\r'
```
and there we have our flag 
```
LITCTF{Youre_telling_me_I_cant_just_throw_elliptic_curves_on_something_and_make_it_100x_secure?_:<}
```
