---
title: Collection of popular tricks related to swapping and inversion pairs
math: true
type: docs
weight: 4
sidebar: 
    open: true
---

## What is this about?
I lately stumbled across a series of problems related to the swapping operation and counting inversion pairs and eventually I started feeling that my theory for these concepts is not very solid. So in this blog post, I'll be investigating a collection of standard popular problems related to this topic.

## Introduction
Let's define `Swapping` first. Swapping refers the exchanging the positions of the adjacent pair of the elements. Applying a swap to `(3, 4)` yields `(4, 3)` and so on. A pair is called an inversion pair if `i < j` and `a[i] > a[j]`. The concepts of inversion pairs in an array and swapping are closely tied as we shall see soon. There's another structure called the permutation cycles in an array which is also very relevant to this topic.

## Swapping changes the parity of Inversion Pairs
Suppose let's say that there are `cnt` inversion pairs in an array `A` of length `n`. Then swapping any two adjacent numbers would change the parity of the number of inversion pairs. This is because a swap would either sort that pair (in that case decrease the number of inversion pairs) or create an extra inversion pair without disturbing the relative orders between any other pairs.

Infact, this statement holds true if we were to not restrict ourselves to only adjacent swaps. Swapping any two elements in the array changes the parity of the count of inversion pairs and this can be easily proved using simple algebra. Suppose, we swap pairs `(i, j)`. Let `l = j - i - 1` which is the number of elements between `i` and `j`. Let's say out of these `l`, `x` numbers are smaller than `a[i]` so there are `x` inversion pairs with `a[i]` and `l - x` non-inversion pairs with `a[i]`. Similarly, let `y` be the number of elements in this range that are greater than `a[j]` so `y` is the count of inversion pairs with `a[j]` and `l - y` is the number of non-inversion pairs. If we make the swap, the non-inversion pairs become the inversion pairs and the inversion pairs become the non-inversion pairs. Therefore, the number of inversion pairs now become `old + (l - x) - x + (l - y) - y = old + 2 * (l - x - y)` which is an addition of an even number, but accounting for the inversion pair created or destroyed between `(i, j)` would add or subtract `1` thus changing the parity.

## How fast can we compute the number of Inversion Pairs
So, now that brings up the question how fast can we compute the number of Inversion Pairs in an array. And what are all the possible standard methods to do so.

### Naive Brute Computation O(n^2)

There is a very naive quadratic time brute force computation solution that computes the number of inversion pairs in an array in `O(n^2)` time complexity. 

Here's an implementation of the idea. Basically we iterate over all the possible `(i, j)` checking if `a[i] > a[j]`.

{{% details title="Brute Solution O(n^2)" closed="true" %}}
```c++
void solve() {
    i64 n;
    std::cin >> n;

    std::vector<i64> a(n + 1, 0);
    for (int i = 1; i <= n; i++) {
        std::cin >> a[i];
    }

    i64 cnt = 0;
    for (int i = 1; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (a[i] > a[j]) cnt++;
        }
    }
}
```
{{% /details %}}

Time Complexity: `O(n^2)`
Space Complexity: `O(1)`
Comments: maybe use for small arrays, very easy to code and get it up running.

### Segment Trees O(nlogn)

The idea here is to quickly compute the number of indices in the prefix that have a value greater than the current index. You need to create a segment tree that supports point updates and range sums (Actually you only need suffix sums, so range sums is a loose more generalizable condition). You will create a segment tree on the array of size `m` where `m` is the upper bound on each array element. 

For each index `i`, you will query `[a[i] + 1, m]` on the segment tree to get the number of elements with greater value. Then you will point update the index `a[i]` in the segment tree to `1` to indicate that this value is present in the prefix now. 

{{% details title="Segment Trees O(nlogn)" closed="true" %}}
```c++

```
{{% /details %}}

Time Complexity: `O(nlogn)`
Space Complexity: `O(max A_i)`

The drawback here might seem that it is taking up too much space and what would I do if ther bound is very large? There's a technique called `Coordinate Compression` that allows us to map these values to range `[1, n]` without losing the information about relative orders of sizes and thus reduce the space complexity to just `O(n)`.

There are various other ways to do this, using:
1. Ordered Sets (C++ Policy Based Data Structures)
2. MergeSort Trees
3. Fenwick Trees
4. AVL Trees

But they have the same asymptotic time complexity and some are difficult to implement so I'm not going to implement these here.

