---
title: P938 Range Sum of BST
math: true
type: docs
weight: 938
sidebar:
  open: false
---

## Problem Statement <a href="https://leetcode.com/problems/range-sum-of-bst/">[Link]</a>

Given the `root` node of a binary search tree and two integers `low` and `high`, return the sum of values of all nodes with a value in the inclusive range `[low, high]`.

## Solution
Just Compute the Inorder Traversal and add the numbers in the range

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
#define i64 long long int
class Solution {
public:
    int rangeSumBST(TreeNode* root, int low, int high) {
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

        i64 sum = 0;
        for (int i = 0; i < ans.size(); i++) {
            if (ans[i] < low || ans[i] > high) continue;
            sum = sum + ans[i];
        }

        return sum;
    }
};
```

Submission Link: https://leetcode.com/problems/range-sum-of-bst/submissions/1778706101/