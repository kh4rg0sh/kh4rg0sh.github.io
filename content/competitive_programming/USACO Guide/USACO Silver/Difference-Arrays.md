---
title: Difference Arrays
type: docs
weight: 3
math: true
sidebar:
    open: true
---

A very interesting as well as an intuitive idea. This is definitely something what you should think about when trying to solve problems related to ranges! I feel like this idea is better demonstrated through a problem

## Motivation 
here's the problem statement

{{< callout >}}
given $Q$ ranges of the form $[L_i, R_i]$ for each each point $x \in [1, N]$ find the number of ranges that contain the point $x$.
{{< /callout >}}

### Naive Solution
so for each point $x$, we could iterate over the ranges and check if that point lies inside the range. the time complexity of this brute force approach would be $O(NQ)$

### Difference Arrays!
the better idea here is to create another array $d$. Initialise it with zero entirely. Now for each range $[L_i, R_i]$ we are going to update `d[L_i] += 1` and `d[R_i + 1] -= 1`. Constructing prefix sums on top of this array, would compute the number of ranges each point `x` is contained within.

{{< callout type="info">}}
This term "Difference Arrays" was popularised here: https://codeforces.com/blog/entry/78762 
The comments also contain links to some really nice problems where this concept could be applied!
{{< /callout >}}

### Code
here's my implementation for the above problem

{{% details title="Solution" closed="true"%}}
```c++
#include <iostream>
#include <vector>

int main() {
    int n, q;
    std::cin >> n >> q;

    std::vector<int> diff(n + 2);
    for (int i = 1, l, r; i <= q; i++) {
        std::cin >> l >> r;
        diff[l] += 1;
        diff[r + 1] -= 1;
    }

    std::vector<int> pref(n + 1);
    for (int i = 1; i <= n; i++) {
        pref[i] = pref[i - 1] + diff[i];
    }

    for (int i = 1; i <= n; i++) {
        std::cout << pref[i] << " \n"[i == n];
    }
}
```
{{% /details %}}