---
layout: post
title: Short Proof of Feuerbach's Conic Theorem
---

# **Statement**  
Let $\triangle ABC$ be a triangle inscribed in a rectangular hyperbola $\mathcal H$.
Prove that the center of $\mathcal H$
lies on the Nine–Point Circle of $\triangle ABC$.

---

This is known as `Feuerbach's Conic Theorem` as cited in *Coolidge, J. L. A Treatise on Algebraic Plane Curves. New York: Dover, 1959*. I recently discovered a short proof for the same, so let's go over that in this blog post.

## Proof
Let's start with a pretty well-known result.

### **Lemma 1**  
Let $\mathcal H$ be a rectangular hyperbola with a point $P$ on it and center $G$.
The reflection of $P$ over $G$ lies on $\mathcal H$.

---

This lemma is well known so we will not prove it here. Let's use it to prove the statement at hand. Let $\mathcal H$ be a fixed rectangular hyperbola through the vertices of
$\triangle ABC$.

If $H$ is the orthocenter of $\triangle ABC$, then $H$ also lies on $\mathcal H$.

Let $E_A, E_B, E_C$ be the midpoints of $AH, BH, CH$, and let
$\triangle H_AH_BH_C$ be the orthic triangle of $\triangle ABC$.

Thus $E_AE_BE_CH_AH_BH_C$ is the Nine–Point Circle of $\triangle ABC$.

Let the tangents to $\mathcal H$ at $(A,H), (B,H), (C,H)$ meet at
$K, M, N$ respectively. Then the lines
$E_AK, E_BM, E_CN$ concur at a point $P$, which is the center of $\mathcal H$.

Consider the reflections of $H,A,B,C$ over $P$, denoted
$Q,R,S,T$. Then $Q,R,S,T$ lie on $\mathcal H$.
Since $AHRQ$ is a parallelogram, applying Pascal’s Theorem on
$HHRQQA$ implies that the tangents at $H$ and $Q$ are parallel.

Let
$$
QS \cap AC = U,
QR \cap BC = V,
QT \cap AB = W.
$$
Then $\triangle VUW$ is the pedal triangle of $Q$ with respect to $\triangle ABC$.

Applying Pascal’s Theorem on $SQRACB$ and $TCBARQ$
implies that $VUW$ is the Simson Line of $Q$.

Hence $Q$ lies on $(ABC)$, and therefore
$P$ lies on the Nine–Point Circle. $\blacksquare$

---

**Remark.**  
If $Q$ is the fourth intersection of the circum–rectangular hyperbola
$\mathcal H$ of $\triangle ABC$ with $(ABC)$, then the Simson Line of $Q$
passes through the center of $\mathcal H$.
