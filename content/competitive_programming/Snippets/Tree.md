---
title: Tree Algorithms
math: true
type: docs
weight: 3
---

Traversal Snippets
## Inorder Traversal (DFS)
{{% details title="Click" closed="true" %}}
```c++
std::vector<int> ans;
std::function<void(TreeNode*)> inorder = [&] (TreeNode* ptr) -> void {
    if (ptr == nullptr) return;
    if (ptr->left != nullptr) {
        inorder(ptr->left);
    }
    ans.push_back(ptr->val);
    if (ptr->right != nullptr) {
        inorder(ptr->right);
    }
    return;
};
inorder(root);
```
{{% /details %}}

## Recursive DFS (Distances and Subtree Sizes)
Compute distances from the root node and subtree sizes in the tree
{{% details title="Click" closed="true" %}}
```c++
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
```
{{% /details %}}

