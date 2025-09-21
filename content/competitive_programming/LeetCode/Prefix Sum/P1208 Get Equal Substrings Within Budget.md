---
title: P1208 Get Equal Substrings Within Budget
math: true
type: docs
weight: 1208
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/get-equal-substrings-within-budget/description/">[Link]</a>

You are given two strings `s` and `t` of the same length and an integer maxCost.

You want to change `s` to `t`. Changing the ith character of `s` to `i`th character of `t` costs `|s[i] - t[i]|` (i.e., the absolute difference between the ASCII values of the characters).

Return the maximum length of a substring of `s` that can be changed to be the same as the corresponding substring of `t` with a cost less than or equal to maxCost. If there is no substring from `s` that can be changed to its corresponding substring from `t`, return 0.

## Solution (Using Two Pointers)
this problem is equivalent to finding the maximum length subarray in an array of positive integers that is bounded by a value. we can employ traditional two pointers that mark the endpoints of a subarray. initialise these two pointers at the leftmost endpoint and then move the right two pointer forward. this should keep moving forward until sum is smaller than target value. if that doesn't hold then move the left pointer forward until the condition holds again and repeat

### Implementation
```c++
class Solution {
public:
    int equalSubstring(string s, string t, int maxCost) {
        int n = s.length();

        std::vector<int> a(n);
        for (int i = 0; i < n; i++) {
            a[i] = (int)(abs(s[i] - t[i]));
        }

        int ans = 0, sum = 0;
        int l = 0, r = 0;
        for (; r < n; r++) {
            sum += a[r];
            while (l < n && sum > maxCost) {
                sum -= a[l++];
            }
            ans = std::max(ans, r - l + 1);
        }

        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/get-equal-substrings-within-budget/submissions/1777935640/