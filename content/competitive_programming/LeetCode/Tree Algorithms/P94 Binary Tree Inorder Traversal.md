---
title: P94 Binary Tree Inorder Traversal
math: true
type: docs
weight: 94
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/binary-tree-inorder-traversal/">[Link]</a>

Given the `root` of a binary tree, return the inorder traversal of its nodes' values.

## Solution (Using DFS)
just recursively evaluate the left child then print the current node value and then evaluate the right child.

### Implementation
```c++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
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
        return ans;
    }
};
```

Submission Link: https://leetcode.com/problems/binary-tree-inorder-traversal/submissions/1778685185/
