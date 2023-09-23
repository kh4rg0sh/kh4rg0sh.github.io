---
title: Birational Equivalences over Elliptic Curves
date: 2023-09-23 00:00:00 +0530
categories: [CTF]
tags: [cryptography]
math: true
---
the challenge that i'll be discussing in this blogpost belongs to one of the CTFs that I played this weekend. this CTF was organised by IIT Bombay and my team finished $5$th on this one. i found the following problem interesting and I found it great to provide an introduction to oneself about the applications of birational equivalences over elliptic curves.  
## Problem 

here are the challenge files: <a href="/ignore/iitb/output.txt">output.txt</a> and <a href="/ignore/iitb/map.sage">map.sage</a>.  you can download and access these files to try the challenge.

### Solution
we first notice that our desired answer can only be obtained if compute the discrete logarithm $sP$ and $tQ$. the toughest part of the challenge is that we are not provided with the curve parameters $c,d$ and $p$ for:

$$ 
E: x^2 + y^2 = c^2 (1 + dx^2y^2)
$$

so our first target should be retrieving these curve parameters. notice that we are given $4$ points on this curve, so we have $4$ modular congruences that we can use to solve for these unknown curve parameters. 

### Finding the Curve Parameters
there's a sweet mathematical trick to do this. we'll eliminate $c$ and solve for $d$ in $\mathbb{Q}$ in the following way:

$$
\frac{x_1^2 + y_1^2}{1+dx_1^2y_1^2} = \frac{x_2^2 + y_2^2}{1 + dx_2^2 y_2^2}
$$

the above equation could be rewritten as 

$$
d = \frac{(x_1^2 + y_1^2) - (x_2^2 + y_2^2)}{x_2^2 y_2^2 (x_1^2 + y_1^2) - x_1^2 y_1^2 (x_2^2 + y_2^2)}
$$

similarly

$$
d = \frac{(x_3^2 + y_3^2) - (x_4^2 + y_4^2)}{x_4^2 y_4^2 (x_3^2 + y_3^2) - x_3^2 y_3^2 (x_4^2 + y_4^2)}
$$

this solves for the variable $d$ in $\mathbb{Q}$. note that the values of $d$ that we obtain from the above two equations are different but they are definitely congruent to each other $\pmod{p}$. let's represent the first and second solutions as 

$$
d_1 = \left(\frac{A_1}{B_1} \right)  \text{ and } d_2 = \left(\frac{C_1}{D_1} \right) \implies p \mid \left(A_1\cdot D_1 - B_1\cdot C_1\right)
$$

similarly we obtain more two values of $d$ solving for the first and fourth equation and the second and the third equation simultaneously, respectively. 

$$
d_3 = \frac{A_2}{B_2}  \text{ and } d_4 = \frac{C_2}{D_2} \implies p \mid \left(A_2\cdot D_2 - B_2\cdot C_2 \right)
$$

hence we can retrieve the prime $p$ using 

$$
p = \gcd(A_1\cdot D_1 - B_1\cdot C_1 , A_2\cdot D_2 - B_2\cdot C_2)
$$

here's a code that retrieves the prime $p$

```py
import math
P = (398011447251267732058427934569710020713094, 548950454294712661054528329798266699762662)
Q = (139255151342889674616838168412769112246165, 649791718379009629228240558980851356197207)
sP = (668047985573768876118879240405851152816285, 602303934490063282429226255925531760405549)
tQ = (573981719081787848384174382698383688032076, 131528097588399746998741329728112062227392)
                                                  
a = (P[0]**2 + P[1]**2) - (Q[0]**2 + Q[1]**2)
b = (P[0]**2)*(P[1]**2)*(Q[0]**2 + Q[1]**2) - (Q[0]**2)*(Q[1]**2)*(P[0]**2+P[1]**2)
c = (sP[0]**2 + sP[1]**2) - (tQ[0]**2 + tQ[1]**2)
d = (sP[0]**2)*(sP[1]**2)*(tQ[0]**2+tQ[1]**2) - (tQ[0]**2)*(tQ[1]**2)*(sP[0]**2+sP[1]**2)
print(b*c-a*d)

a = (P[0]**2 + P[1]**2) - (sP[0]**2 + sP[1]**2)
b = (P[0]**2)*(P[1]**2)*(sP[0]**2 + sP[1]**2) - (sP[0]**2)*(sP[1]**2)*(P[0]**2+P[1]**2)
c = (Q[0]**2 + Q[1]**2) - (tQ[0]**2 + tQ[1]**2)
d = (Q[0]**2)*(Q[1]**2)*(tQ[0]**2+tQ[1]**2) - (tQ[0]**2)*(tQ[1]**2)*(Q[0]**2+Q[1]**2)
print(a*d-b*c)
print(math.gcd(7071219732651773103050536786297430107880920209760319422896051704232359334946510489279247874743255488065255719508587296522501641810752880945870046972695159325922390743511352381074495737954906202346019357754295149194446989029460695581802220996990859220286563343660754582630250290128787071072692170441996795930505512779254626194006529360,3284907571060101516269907603367326061766925243017122049530492811689814960742438449611960789907315621051862806036285564546649253586450644061684558936892723490414360147045394515784828060763375030663201741344342442038147163837773420199804393890220680963929024075705233926055418091799949765383352712004680753501238237565514233804934962800))
```

if you run this and factorise the output on factordb, we actually get 
```py
p = 903968861315877429495243431349919213155709
```
once we have the modulus, retrieving the parameters $c$ and $d$ is a piece of cake

```py 

p = 903968861315877429495243431349919213155709 
P = (398011447251267732058427934569710020713094, 548950454294712661054528329798266699762662)
Q = (139255151342889674616838168412769112246165, 649791718379009629228240558980851356197207)
sP = (668047985573768876118879240405851152816285, 602303934490063282429226255925531760405549)
tQ = (573981719081787848384174382698383688032076, 131528097588399746998741329728112062227392)

Px = Zp(P[0])
Py = Zp(P[1])
Qx = Zp(Q[0])
Qy = Zp(Q[1])
sPx = Zp(sP[0])
sPy = Zp(sP[1])
tQx = Zp(tQ[0])
tQy = Zp(tQ[1])

d = (((Px**2 + Py**2) - (Qx**2 + Qy**2))*(pow((Px**2)*(Py**2)*(Qx**2+Qy**2) - (Qx**2)*(Qy**2)*(Px**2+Py**2),-1,p)))%p           
d = Zp(540431316779988345188678880301417602675534)
c = mod((Px**2+Py**2)*(pow(1 + d*(Px**2)*(Py**2),-1,p)),p).sqrt()
c = Zp(241270766892588524651461499096659309771090)
```

we can do a quick assert and check that the given points do satisfy the curve equation now
```py
assert Px**2 + Py**2 == (c**2)*(1 + d*(Px**2)*(Py**2))
assert Qx**2 + Qy**2 == (c**2)*(1 + d*(Qx**2)*(Qy**2))
assert sPx**2 + sPy**2 == (c**2)*(1 + d*(sPx**2)*(sPy**2))
assert tQx**2 + tQy**2 == (c**2)*(1 + d*(tQx**2)*(tQy**2))
```
### Transforming Curves
since sagemath supports the algorithms to calculate the discrete logarithm over elliptic curves in weierstrass form, that is the curves of the form 

$$
y^2 + a_1 xy + a_3y = x^3 + a_2x^2 + a_4x + a_6
$$

hence we must transform our curve to the above form. to do so we must perform three curve transformations:
1. transform the curve to edward form

an equation of an elliptic curve in edward form is represented in the following way:

$$
x^2 + y^2 = 1 + dx^2 y^2
$$

to perform the required transformation, we must map

$$
x \longrightarrow x/c 
$$

$$ 
y \longrightarrow y/c
$$

$$
d \longrightarrow d\cdot c^4 
$$

here's a code that does the above

```py
## check if the point lies on the curve: x^2 + y^2 = c^2(1 + dx^2y^2)
assert Px**2 + Py**2 == (c**2)*(1 + d*(Px**2)*(Py**2))
assert Qx**2 + Qy**2 == (c**2)*(1 + d*(Qx**2)*(Qy**2))
assert sPx**2 + sPy**2 == (c**2)*(1 + d*(sPx**2)*(sPy**2))
assert tPx**2 + tPy**2 == (c**2)*(1 + d*(tPx**2)*(tPy**2))

## transform the curve to: x^2 + y^2 = 1 + dx^2y^2
d = (d*pow(c,4,p))%p
Px = Px*pow(c,-1,p)
Py = Py*pow(c,-1,p)
Qx = Qx*pow(c,-1,p)
Qy = Qy*pow(c,-1,p)
sPx = sPx*pow(c,-1,p)
sPy = sPy*pow(c,-1,p)
tQx = tQx*pow(c,-1,p)
tQy = tQy*pow(c,-1,p)

## check if the point lies on the curve: x^2 + y^2 = 1+ dx^2y^2
assert Px**2 + Py**2 == 1 + d*(Px**2)*(Py**2)
assert Qx**2 + Qy**2 == 1 + d*(Qx**2)*(Qy**2)
assert sPx**2 + sPy**2 == 1 + d*(sPx**2)*(sPy**2)
assert tQx**2 + tQy**2 == 1 + d*(tQx**2)*(tQy**2)
```

2. transform the modified curve to montgomery form

an equation of an elliptic curve in the montgomery form is represented in the following way:

$$
By^2 = x^3 + Ax^2 + x
$$

to perform the above transformation, we must map

$$
x \longrightarrow \frac{1+y}{1-y}
$$

$$
y \longrightarrow \frac{2(1+y)}{x(1-y)}
$$

and we introduce new coefficients 

$$
A = \left(\frac{4}{1-d}-2\right)
$$

$$
B = \left(\frac{1}{1-d}\right)
$$

here's a code that does the above

```py
## transform the curve to: By^2 = x^3 + Ax^2 + x
e = (1-d)%p
B = pow(e,-1,p)
A = (4*pow(e,-1,p)-2)%p

Px1 = ((1+Py)*(pow(1-Py,-1,p)))
Py1 = ((2*(1+Py))*(pow(Px*(1-Py),-1,p)))%p
Qx1 = ((1+Qy)*(pow(1-Qy,-1,p)))
Qy1 = ((2*(1+Qy))*(pow(Qx*(1-Qy),-1,p)))%p
sPx1 = ((1+sPy)*(pow(1-sPy,-1,p)))
sPy1 = ((2*(1+sPy))*(pow(sPx*(1-sPy),-1,p)))%p
tQx1 = ((1+tQy)*(pow(1-tQy,-1,p)))
tQy1 = ((2*(1+tQy))*(pow(tQx*(1-tQy),-1,p)))%p

## check if the point lies on the curve: By^2 = x^3 + Ax^2 + x
assert B*(Py1**2) == (Px1**3) + A*(Px1**2) + Px1
assert B*(Qy1**2) == (Qx1**3) + A*(Qx1**2) + Qx1
assert B*(sPy1**2) == (sPx1**3) + A*(sPx1**2) + sPx1
assert B*(tQy1**2) == (tQx1**3) + A*(tQx1**2) + tQx1

```

3. transform the montgomery form to weierstrass form

an equation of an elliptic curve in the montgomery form is represented in the following way:

$$
y^2 = x^3 + Cx + D
$$

to perform the above transformation, we must map

$$
x \longrightarrow \frac{\left(x + \frac{A}{3}\right)}{B}
$$

$$
y \longrightarrow \left(\frac{y}{B}\right)
$$

and we define new coefficients 

$$
C = \left(\frac{1}{B^2} - \frac{A^2}{3B^2}\right)
$$

$$
D = \left( \frac{2A^3-9A}{27B^3}\right)
$$

here's a code that does the above

```py
## transform the curve to: y^2 = x^3 + Cx + D
C = (pow(pow(B,2,p),-1,p) - pow(A,2,p)*(pow(3*pow(B,2,p),-1,p)))%p
D = ((2*pow(A,3,p)-9*A)*pow((27*pow(B,3,p)),-1,p))%p
Py2 = Py1*pow(B,-1,p)
Px2 = (Px1+A*pow(3,-1,p))*pow(B,-1,p)
Qy2 = Qy1*pow(B,-1,p)
Qx2 = (Qx1+A*pow(3,-1,p))*pow(B,-1,p)
sPy2 = sPy1*pow(B,-1,p)
sPx2 = (sPx1+A*pow(3,-1,p))*pow(B,-1,p)
tQy2 = tQy1*pow(B,-1,p)
tQx2 = (tQx1+A*pow(3,-1,p))*pow(B,-1,p)

## check if the point lies on the curve: y^2 = x^3 + Cx + D
assert Py2**2 == Px2**3 + C*Px2 + D
assert Qy2**2 == Qx2**3 + C*Qx2 + D
assert sPy2**2 == sPx2**3 + C*sPx2 + D
assert tQy2**2 == tQx2**3 + C*tQx2 + D
```

now that we have mapped out points to an elliptic curve in the weierstrass form, we can declare our elliptic curve and compute the discrete logarithm

### Computing the Discrete Logarithm

an easy and quick check upon the order of this curve reveals that it's vulnerable to the pohlig-hellman attack, and we can easily do that in sagemath

```py
E = EllipticCurve(GF(p),[C,D])
P = E(Px2,Py2)
Q = E(Qx2,Qy2)
sP = E(sPx2,sPy2)
tQ = E(tQx2,tQy2)

a = discrete_log(sP,P,P.order(),operation='+')
b = discrete_log(tQ,Q,Q.order(),operation='+')
print(long_to_bytes(a)+long_to_bytes(b))
```
running the above script yields the desired flag
```
iitbCTF{!3ll1pt1c_3qn_1n_3dw4rd5_f0rm}
```