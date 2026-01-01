---
layout: post
title: Re-discovering the Artzt Parabola
---

## Let's try to motivate this parabola!
> Let $d_1 , d_2$ be two abitrary lines that are not perpendicular. Let $A,B$ be abitrary points lie on $d_1,d_2$. How to construct a parabola that is tangent to $d_1,d_2$ at $A,B$.

I was working on this construction because it is impossible to construct a parabola tangent to two lines at given points in GeoGebra. While searching for some lemmas in *S.L. Loney's Coordinate Geometry*, I found the following result:


> Let $\mathcal{P}$ be a parabola with $X,Y \in \mathcal{P}$.  
> Let the tangents at $X,Y$ meet at $A$.  
> Then,
> $ \triangle TAY \sim \triangle TXA$

This lemma clearly motivates the construction of a parabola with focus at the Dumpty Point and so we have the following problem.

---

## **Problem**
Let $\triangle ABC$ be a triangle. Let $D$ be the midpoint of the $A$-symmedian chord. Let $M$ be the midpoint of $BC$. Let $AM$ intersect the nine-point circle at $M'$. Let $\ell$ be the line perpendicular to $AM$ at $M'$.

Prove that there exists a parabola $\mathcal{P}$ with focus at $D$, tangent to $AB$ and $AC$ at $B$ and $C$, and with directrix $\ell$.

---

I showed this problem to some of my friends and they communicated back some really beautiful proofs for this, which I'd like to post here.

## **Proof (by Shantanu Nene)**

> Let $B'$ and $C'$ be midpoints of $AC$ and $AB$ respectively.  
> Let $\ell$ meet $AC,AB$ at $E,F$ respectively. Let $AM$ meet $BD$ at $P$ and $CD$ at $Q$.

> Using angle chasing (symmedian properties, midpoint theorem, and the fact that $M',B',C',M$ are concyclic), we see that $E,M',D,Q,B'$ are concyclic. Hence
> $\angle EDC = \angle EM'Q = 90^\circ$.
> Similarly, $\angle FDB = 90^\circ$

> Thus it is sufficient to show that $B$ and $C$ lie on the parabola with focus $D$ and directrix $\ell$.

> Let $G$ be the foot from $C$ to $\ell$. Since $\angle EDC = \angle EGC = 90^\circ$, and by angle chasing,
> $\angle ECD = \angle ECG$, the quadrilateral $EGCD$ is a kite.  
> Hence $CG = CD$, so $C$ lies on the parabola. 

> Similarly, $B$ also lies on the parabola, and we are done.

---

## **Proof (by Aatman Supkar)**

> Consider an in-parabola of $AB'C'$ whose directrix is the perpendicular bisector of $AM'$.

> Since the foci of the parabola are isogonal conjugates, if the axis is parallel to the $A$-median, the other focus lies on the $A$-symmedian.

> Also, since the isogonal conjugate of a point at infinity lies on the circumcircle, the focus lies on $\odot(AB'C')$, which is a homothety of ratio $\tfrac{1}{2}$ of $\odot(ABC)$ from $A$.

> Therefore $D$ lies on this circle, and is the focus of the in-parabola.

---

I posted this result on AoPS <a href="https://artofproblemsolving.com/community/q1h1912112p13117117" target="_blank">here</a>, which has some more beautiful results and extensions.
