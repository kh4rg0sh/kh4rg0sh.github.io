---
title: P834 Sum of Distances in Tree
math: true
type: docs
weight: 834
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/sum-of-distances-in-tree/">[Link]</a>

There is an undirected connected tree with `n` nodes labeled from `0` to `n - 1` and `n - 1` edges.

You are given the integer `n` and the array edges where `edges[i] = [ai, bi]` indicates that there is an edge between nodes `ai` and `bi` in the tree.

Return an array answer of length `n` where `answer[i]` is the sum of the distances between the `i`th node in the tree and all other nodes.

## Solution (Rerooting Technique)
This is a very popular example of the Rerooting Technique (DP on trees). The idea is to root the tree at a node (let's say 0) and then compute all the distances and sum them. This can be done in `O(N)`. Now here comes the trick. We will use this to compute the answer for all the other nodes in `O(1)` using the observation that for a child of the root, the answer is `dp[root] - sz[child] + (n - sz[child])` (where `sz[i] = ` size of the subtree at node `i`). intuitively, if we hop onto a child, the answer distances would reduce by `1` for all the nodes in that subtree and increase by `1` for all the nodes not in that subtree (which explains the dp transition state).

### Implementation
```c++
class Solution {
public:
    vector<int> sumOfDistancesInTree(int n, vector<vector<int>>& edges) {
        std::vector<int> adj[n + 1];
        for (auto u: edges) {
            adj[u[0]].push_back(u[1]);
            adj[u[1]].push_back(u[0]);
        }

        std::vector<int> dist(n, 0);
        std::vector<int> sz(n, 0);

        std::function<int(int, int)> dfs = [&] (int par, int node) -> int {
            sz[node] += 1;
            for (auto u: adj[node]) {
                if (u == par) continue;
                dist[u] = dist[node] + 1;
                sz[node] += dfs(node, u);
            }

            return sz[node];
        };

        dfs(-1, 0);

        std::vector<int> ans(n, 0);
        for (int i = 0; i < n; i++) {
            ans[0] += dist[i];
        }

        std::function<void(int, int)> compute = [&] (int par, int node) -> void {
            for (auto u: adj[node]) {
                if (u == par) continue;
                ans[u] = ans[node] + n - 2 * sz[u];
                compute(node, u);
            }
            return;
        };

        compute(-1, 0);
        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/sum-of-distances-in-tree/submissions/1778704128/
