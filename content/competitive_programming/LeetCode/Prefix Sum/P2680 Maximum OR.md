---
title: P2680 Maximum OR
math: true
type: docs
weight: 2680
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/maximum-or/description/">[Link]</a>

You are given a `0-indexed` integer array nums of length `n` and an integer `k`. In an operation, you can choose an element and multiply it by `2`.

Return the maximum possible value of `nums[0] | nums[1] | ... | nums[n - 1]` that can be obtained after applying the operation on nums at most `k` times.

Note that `a | b` denotes the bitwise or between two integers `a` and `b`.

## Solution (Prefix and Suffix bitwise OR)
This is a cool problem. The first observation is that it is optimal to apply all the `k` operations to a single element. This is because we want that number to be as big as possible to maximise the bitwise OR. The next question arises what element should that be? Turns out, we don't have to brainstorm that. We can just brute force compute the answer for all such choices of the element using prefix and suffix bitwise OR.

### Implementation
```c++
#define i64 long long int

class Solution {
public:
    long long maximumOr(vector<int>& nums, int k) {
        int n = nums.size();
        
        std::vector<i64> pref(n + 1, 0);
        std::vector<i64> suff(n + 2, 0);

        for (int i = 1; i <= n; i++) {
            pref[i] = pref[i - 1] | nums[i - 1];
        }
        for (int i = n; i > 0; i--) {
            suff[i] = suff[i + 1] | nums[i - 1];
        }

        i64 ans = 0;
        for (int i = 0; i < n; i++) {
            ans = std::max(ans, ((nums[i] * 1LL) << k) | (pref[i] | suff[i + 2]));
        }

        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/maximum-or/submissions/1777944062/
