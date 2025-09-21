---
title: P2574 Left and Right Sum Differences
math: true
type: docs
weight: 2574
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/left-and-right-sum-differences/description/">[Link]</a>

You are given a `0`-indexed integer array nums of size `n`.

Define two arrays leftSum and rightSum where:

`leftSum[i]` is the sum of elements to the left of the index `i` in the array nums. If there is no such element, `leftSum[i] = 0`.
`rightSum[i]` is the sum of elements to the right of the index `i` in the array nums. If there is no such element, `rightSum[i] = 0`.
Return an integer array answer of size `n` where `answer[i] = |leftSum[i] - rightSum[i]|`.

## Solution (Prefix and Suffix Sums)
this is straightforward prefix and suffix sums. just use these to construct the required array.

### Implementation
```c++
class Solution {
public:
    vector<int> leftRightDifference(vector<int>& nums) {
        int n = nums.size();
        std::vector<int> leftSum(n, 0);
        std::vector<int> rightSum(n, 0);

        int sum = 0;
        for (int i = 0; i < n; i++) {
            leftSum[i] = sum;
            sum += nums[i];
        }

        sum = 0;
        for (int i = n - 1; i >= 0; i--) {
            rightSum[i] = sum;
            sum += nums[i];
        }

        std::vector<int> ans(n, 0);
        for (int i = 0; i < n; i++) {
            ans[i] = abs(leftSum[i] - rightSum[i]);
        }

        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/left-and-right-sum-differences/submissions/1777939748/