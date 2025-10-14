---
title: Problem A
math: true
type: docs
weight: 1
---

## Problem Statement <a href="https://codeforces.com/contest/2151/problem/A">[Link]</a>
![alt text](image.png)

## During Contest
Initially I was on the wrong path but I immediately corrected my thinking. The idea is to detect a point of turning (which is the index `i` such that `a[i] >= a[i + 1]`). If such a point exists then the answer is `1` because the array is fixed. otherwise we know the last element in the maximum and we jut have to count the number of occurrences of this in the original array which is `n - max + 1`

### Implementation
this is what I did in the contest
```c++
void solve() {
    ll n, m;
    std::cin >> n >> m;
 
    std::vector<ll> a(m + 1, 0);
    for (ll i = 1; i <= m; i++) {
        std::cin >> a[i];
    }
 
    bool turn = false;
    for (ll i = 1; i < m; i++) {
        if (a[i] >= a[i + 1]) {
            turn = true;
        }
    }
 
    if (turn) {
        std::cout << 1 << '\n';
    } else {
        std::cout << (n - a[m] + 1) << '\n';
    }
}
```

Submission Link: https://codeforces.com/contest/2151/submission/340148931
