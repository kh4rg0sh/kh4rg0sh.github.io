---
title: P98 Validate Binary Search Tree
math: true
type: docs
weight: 98
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/validate-binary-search-tree/">[Link]</a>

Given the root of a binary tree, determine if it is a valid binary search tree (BST).

A valid BST is defined as follows:

The left subtree of a node contains only nodes with keys strictly less than the node's key.
The right subtree of a node contains only nodes with keys strictly greater than the node's key.
Both the left and right subtrees must also be binary search trees.

## Solution (Using DFS)
compute the inorder traversal and check if that array is sorted.

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
    bool isValidBST(TreeNode* root) {
        bool valid = true;
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
        for (int i = 0; i < ans.size() - 1; i++) {
            if (ans[i + 1] <= ans[i]) valid = false;
        }
        return valid;
    }
};
```
Submission Link: https://leetcode.com/problems/validate-binary-search-tree/submissions/1778685040/