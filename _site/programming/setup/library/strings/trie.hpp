#pragma once
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

struct TrieNode {
    i64 count;
    TrieNode* link[26];
    TrieNode() {
        count = 0LL;
        for (int i = 0; i < 26; i++) {
            link[i] = nullptr;
        }
    }
};

struct Trie {
    TrieNode* root;
    Trie() {
        root = new TrieNode();
    }

    i64 add(std::string s) {
        i64 ans = 0;
        TrieNode* new_root = root;
        for (int i = 0; i < s.length(); i++) {
            if (new_root->link[s[i] - 'a'] == nullptr) {
                new_root->link[s[i] - 'a'] = new TrieNode();
            }
            new_root = new_root->link[s[i] - 'a'];
            ans += new_root->count;
            new_root->count++;
        }
        return ans;
    }
};
