---
title: P238 Product of Array Except Self
math: true
type: docs
weight: 238
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/product-of-array-except-self/description/">[Link]</a>

Given an integer array nums, return an array answer such that `answer[i]` is equal to the product of all the elements of nums except `nums[i]`.

The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

You must write an algorithm that runs in O(n) time and without using the division operation.

## Solution (Prefix and Suffix Products)
For this problem we will compute the prefix and suffix products of the array. The desired output would be the array formed using the proper prefix and suffix at that index.

### Implementation
```c++
class Solution {
public:
    vector<int> productExceptSelf(vector<int>& nums) {
        int n = nums.size();

        std::vector<int> ans(n, 0);
        std::vector<int> pref(n + 1, 1);
        std::vector<int> suff(n + 2, 1);

        for (int i = 1; i <= n; i++) {
            pref[i] = pref[i - 1] * nums[i - 1];
        }
        for (int i = n; i > 0; i--) {
            suff[i] = suff[i + 1] * nums[i - 1];
        }
        for (int i = 0; i < n; i++) {
            ans[i] = pref[i] * suff[i + 2];
        }

        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/product-of-array-except-self/submissions/1777936394/
