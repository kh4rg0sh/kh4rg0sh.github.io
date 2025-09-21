---
title: P209 Minimum Size Subarray Sum
math: true
type: docs
weight: 209
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/minimum-size-subarray-sum/description/">[Link]</a>

Given an array of positive integers nums and a positive integer target, return the minimal length of a subarray whose sum is greater than or equal to target. If there is no such subarray, return 0 instead.
 
## Solution (Using Two Pointers)
we can use two pointers approach for this problem. the two pointers will determine the left and the right end of the subarray. we keep these two pointers initially on the left end and keep moving the right pointer forward until the subarray sum is greater than or equal to target. as soon as that happens, we know that the sum of the subarray is going to increase hereforth, and therefore for the fixed left-end this is the minimum length subarray that we've found. keeping the right pointer fixed we move the left pointer forward until `sum >= target` and continue the algorithm.

### Implementation

```c++
class Solution {
public:
    int minSubArrayLen(int target, vector<int>& nums) {
        int n = nums.size();

        int sum = 0, ans = INT_MAX;
        int l = 0, r = 0;
        for (; r < n; r++) {
            sum += nums[r];
            while (l < n && sum >= target) {
                ans = std::min(ans, r - l + 1);
                sum -= nums[l++];
            }
        }

        if (ans == INT_MAX) ans = 0;
        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/minimum-size-subarray-sum/submissions/1777935996
