---
title: P2536 Increment Submatrices by One
math: true
type: docs
weight: 2536
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/increment-submatrices-by-one/description/">[Link]</a>

You are given a positive integer `n`, indicating that we initially have an `n x n`, `0`-indexed integer matrix `mat` filled with zeroes.

You are also given a 2D integer array query. For each `query[i] = [row1i, col1i, row2i, col2i]`, you should do the following operation:

Add `1` to every element in the submatrix with the top left corner `(row1i, col1i)` and the bottom right corner `(row2i, col2i)`. That is, add `1` to `mat[x][y]` for all `row1i <= x <= row2i` and `col1i <= y <= col2i`.

Return the matrix mat after performing every query.

## Solution (2D Difference Arrays)
this problem is a straight forward implementation of the concept of 2D difference arrays. these are used to compute interval updates. In our case we have a 2D range update and we will add a +1 and -1 in our difference arrays to denote the boundaries of the update. Computing the prefix sum over this difference array would yield the desired matrix `mat`

### Implementation
```c++
class Solution {
public:
    vector<vector<int>> rangeAddQueries(int n, vector<vector<int>>& queries) {
        int mat_diff[n + 1][n + 1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                mat_diff[i][j] = 0;
            }
        }

        // compute the 2D difference array
        for (auto u: queries) {
            mat_diff[u[0]][u[1]] += 1;
            mat_diff[u[0]][u[3] + 1] -= 1;
            mat_diff[u[2] + 1][u[1]] -= 1;
            mat_diff[u[2] + 1][u[3] + 1] += 1;
        }

        // computing the prefix sum over the difference array
        std::vector<std::vector<int>> mat(n, std::vector<int>(n));
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                mat[i][j] = mat_diff[i][j];
                if (i > 0) mat[i][j] += mat[i - 1][j];
                if (j > 0) mat[i][j] += mat[i][j - 1];
                if (i > 0 && j > 0) mat[i][j] -= mat[i - 1][j - 1];
            }
        }

        return mat;
    }   
};
```

Submission Link: https://leetcode.com/problems/increment-submatrices-by-one/submissions/1777934521/


