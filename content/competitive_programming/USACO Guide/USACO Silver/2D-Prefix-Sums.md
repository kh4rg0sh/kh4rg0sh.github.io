---
title: 2D-Prefix Sums
type: docs
weight: 2
math: true
sidebar:
    open: true
---

2D Prefix Sums extend the idea of 1D prefix sums to higher dimension (if it wasn't already something you guessed).

## Motivating Example [CSES Forest Queries]
Suppose you are given an $n \times n$ grid and some of the cells of the grid occupy a tree each. We need to process queries to answer the number of trees in a rectangle.

### Naive Computation
For each rectangle, we can just iterate over each square and count the number of tress. However, on an average this would cost us $O(N^2)$ time. For $Q$ queries, that would be $O(N^2Q)$ time complexity.

### Speed up with 2D-Prefix Sums
If you think about this carefully, a 2D-Prefix Sum is just a rectangle with the top leftmost corner of the top leftmost square. The idea of 2D-prefix sums is subtracting smaller rectangles from larger rectangles. Formally, we could write

$$
\sum_{i=l_1}^{l_1} \sum_{j=r_1}^{r_2} A[i,j] = \sum_{i=1}^{l_2} \sum_{j=1}^{r_2}A[i,j] - \sum_{i=1}^{l_2} \sum_{j=1}^{r_1 - 1} A[i, j] - \sum_{i=1}^{l_1 - 1} \sum_{j = 1}^{r_2} A[i, j] + \sum_{i = 1}^{l_1 - 1} \sum_{j = 1}^{r_1 - 1} A[i, j]
$$

if we denote the 2D-prefix sum of array $A$ by $p$, then the above expression is

$$
p[l_2, r_2] - p[l_2, r_1 - 1] - p[l_1 - 1, r_2] + p[l_1 - 1, r_1 - 1] 
$$

computing this takes $O(1)$ time. and therefore, this allows us to process $Q$ queries in just $O(Q)$ time complexity with $O(N^2)$ precomputation. With 2D-Prefix sums, we optimise our computation algorithm from $O(N^2Q)$ to $O(N^2 + Q)$.

### Code
here's my implementation for the above problem [CSES Forest Queries]

{{% details title="Solution" closed="true" %}}
```c++
#include <iostream>

int main() {
    int n, q;
    std::cin >> n >> q;

    int a[n + 1][n + 1];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            char c;
            std::cin >> c;

            a[i][j] = (c == '*');
        }
    }

    int pref[n + 1][n + 1];
    for (int i = 0; i <= n; i++) pref[i][0] = 0;
    for (int j = 0; j <= n; j++) pref[0][j] = 0;
    
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            pref[i][j] = pref[i - 1][j] + pref[i][j - 1] + a[i][j] - pref[i - 1][j - 1];
        }
    }

    for (int i = 1, x1, x2, y1, y2; i <= q; i++) {
        std::cin >> y1 >> x1 >> y2 >> x2;

        std::cout << (pref[y2][x2] - pref[y2][x1 - 1] - pref[y1 -1][x2] + pref[y1 - 1][x1 - 1]) << '\n';
    }
}
```
{{% /details %}}