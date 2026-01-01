---
layout: post
title: Constructing Inconic from Pair of Isogonal Conjugates
---

# **Statement**  
Let $(P,Q)$ be a pair of isogonal conjugates with respect to $\triangle ABC$. Let $R$ be the midpoint of $PQ$. Let $M$ be the isotomic conjugate of the anticomplement of $R$. If $\triangle DEF$ is the cevian triangle of $M$ with respect to $\triangle ABC$, prove that $D,E,F$ are the tangency points of the inconic whose foci are $P$ and $Q$.

---

## Proof
### **Lemma 1**  
Let $P$ be a point outside ellipse $\mathcal E$. If $PX$ and $PY$ are tangents to $\mathcal E$ from $P$, and $F_1,F_2$ are the foci of $\mathcal E$, then $F_1P$ and $F_2P$ are isogonal with respect to $\angle XPY$.

#### **Proof**  
Using the optical property of the ellipse, $P$ is the $F_1$-excenter with respect to $\triangle F_1XY$. $\square$

---

### **Lemma 2**  
The complement of the Nagel point is the incenter.

#### **Proof**  
Let $(I)$ touch $BC$ at $D$. Let $AE_A$ be the isotomic of $AD$, with $E_A\in BC$. Let
$$AE_A\cap (I)=E \implies D,I,E\text{ are collinear}.$$
Using *USAMO 2001/2* and the fact that $IM_A\parallel AE_A$, we obtain
$$IM_A=\tfrac12 AN_a \implies I,G,N_a\text{ are collinear},$$
so $I$ is the complement of $N_a$. $\square$

---

Let $\Omega$ be the inconic tangent at $D,E$ and $F$. It is enough to prove that $R$ is the center of this conic, as it is well known that the foci will be isogonal conjugates, and there is a unique conic tangent to the sides of the triangle, given its center.

We can now make $\Omega$ into a circle with an affine transformation. $M$ becomes the Gergonne point, so $R$ becomes the Nagel point, as it is still the isotomic conjugate of $M$. The anticomplement of the Nagel point is the incenter. Hence $R$ is the center of $\Omega$, and we are done.
