---
linkTitle: BackdoorCTF 2023
title: BackdoorCTF 2023 
type: docs
math: true
weight: 1
date: '2025-08-26'
---

InfosecIITR hosted the annual CTF, "Backdoor CTF," which ran for an impressive `48` hours, starting from the `16th of December` to the `18th of December`. This was the first time I participated as a CTF organizer and a problem setter. Also, it was a huge event this time, with approximately `1300 teams` registering and `800 teams` having a non-zero score. I was anxious as well as excited to contribute by proposing problems for the event. In the end, I set a total of `six problems`, with crux ideas for two out of those six challenges. All the cryptography problems can be found <a href="https://github.com/MmukulKhedekar/BackdoorCTF2023-Crypto">here</a>. I personally found <a href="https://connor-mccartney.github.io/cryptography/other/BackdoorCTF-2023-writeups">this</a> writeup to be really cool and concise. Apart from that, <a href="https://ctfwriteups.org/ctfs/658035f233b399e7fe20f655/edit">this</a> is a cool collection of writeups. 

I'll quickly explain a background of how i came up with these problems and a sketch of how to solve them.

## mini_RSA_v1 [310 solves]

I proposed the idea for this problem. It was scripted by my peer. We initially wanted to make a problem revolving around the cool identity

$$
    p ^ q + q ^ p \equiv p + q \pmod{pq}
$$

but then we realised that this problem had already appeared in contest earlier this year, so we had to scrap that. I realised that infact for any integers $a$ and $b$, it holds that, 

$$
 p^{\left( q^a\right)} + q^{\left( p^b\right)} \equiv p + q \pmod{pq}
$$

and hence the problem

## mini_RSA_v2 [77 solves]

I kinda overlooked the small size of the public exponent `e` in the RSA encryption that lead to the unintended small exponent attack on the problem. since that wasn't the intended solve, we rolled out the ver2 of the problem with a larger public exponent (`e = 65537`). Now the intended way to solve this calculate the euler totient function of the public modulus using the extra leaked info (`s + t = p + q`).

## PRSA [70 solves]

I know this was a kinda popular/textbook problem. There are lots of texts and implementations based on RSA on polynomial rings that you can find with a single google search. Nevertheless, I wanted it to be an introductory "sage" based problem, so I let it slip anyway.

A quick description of the challenge would be the textbook RSA problem but instead on polynomial rings instead of the ring of two coprime primes. The intended way to solve this was to factor the public modulus polynomial into two irreducible polynomials in the given polynomial ring and evaluate the euler totient using 

$$
    \mid \mathbb{F}[x]^{\star} / \left(P_1(x) P_2(x)\right) \mid = \mid \mathbb{F}[x]^{\star} / P_1(x) \times \mathbb{F}[x]^{\star} / P_2(x) \mid 
$$

$$
= \left(2 ^{\text{deg} \left(P_1(x) \right)} - 1 \right) \times \left(2 ^{\text{deg} \left(P_2(x) \right)} - 1 \right)
$$

then using the euler totient, we calculate the private exponent and decrypt the message. 

There was an unintended solve, where you brute force over the degree of the polynomials to reverse engineer the original polynomial degree (since the degrees were small). I had realised that there could be this unintended solve when I wrote this challenge, but I let it slip since I wanted this to be more about reading and writing sage codes.

## Rebellious [16 solves]

Again a straight forward DLOG based challenge, but instead of implementing the system over an elliptic curve, I chose an Ellipse. There were many approaches to this problem. The intended solution was to observe that $p \equiv 1 \pmod{4}$. This means that imaginary numbers exist in this prime field. Now you can observe that,

$$
\frac{x^2}{a^2} + \frac{y^2}{b^2} \equiv \left(\frac{x}{a} + \sqrt{-1} \frac{y}{b} \right) \cdot \left(\frac{x}{a} - \sqrt{-1} \frac{y}{b} \right) \equiv 1 \pmod{p}
$$

If we let $ u = \left(\frac{x}{a} + \sqrt{-1} \frac{y}{b} \right)$ and $ v = \left(\frac{x}{a} - \sqrt{-1} \frac{y}{b} \right)$, it can be observed that 

$$
    v \equiv u ^ {-1} \pmod{p}
$$

and similarly you can show that there's an isomorphism mapping from the given group to $\mathbb{F}_p$ explicity given by

$$
    \phi \left( P (x, y)\right) = \left(\frac{x}{a} + \sqrt{-1} \frac{y}{b} \right) \pmod{p} 
$$

Now transform the problem to this prime field and solve the DLOG. I purposely chose `p` to be an unsafe prime so that people choose this approach.

## Secure Matrix Transmissions [20 solves]

I was motivated by the result that the diagonal matrix in the matrix diagonalization contains the eigenvalues of the matrix and thus this challenge. I chose a small dimension `N = 6` so that this becomes the intended approach as even a naive brute would require $(N! \times N!)$ operations and thats not too much

## Secure Matrix Transmissions v2 [1 solve]

This was system was implemented from the following <a href="https://www.degruyter.com/document/doi/10.1515/jmc.2011.010/html"> paper</a> under the heading BCFRX scheme. I really didnt want to throw challenges based off papers directly but I had no other choice since the teams on this CTF were really good at cryptography and had butchered almost all the other cryptography problems.

To break this system, one may implement the `Linear Algebra` attack of solving simultaneous systems of equations as described in the paper. Otherwise, as pointed out by `Neobeo` <a href="https://discord.com/channels/916568950375059476/916693278701781103/1187542230345470052">here</a> we may lift the group from $\mathbb{F}\_{p}$ to $\mathbb{F}_{p^{10}}$ to diagonalise and solve for the shared secret as all the eigenvalues of the given matrices exist in the latter.
