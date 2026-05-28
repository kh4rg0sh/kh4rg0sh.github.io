#pragma once
#include "bits/stdc++.h"

using namespace std;
using i64 = long long;

struct Node {
    i64 val;
    Node(i64 v = 0): val(v) {}

    Node& operator+=(const Node& other) {
        val += other.val;
        return *this;
    }
};

template <typename Merge>
struct IterativeSegtree {
    i64 N;
    vector<Node> tree;
    Merge merge;
    Node identity;

    IterativeSegtree(i64 n, vector<i64>& a,
                    function<Node(const Node&, const Node&)> merge,
                    Node identity): N(n), merge(merge), identity(identity) {
        tree.assign(2 * N, identity);
        construct(a);
    }

    void construct(vector<i64>& a) {
        for (int i = 1; i <= N; i++) tree[i + N - 1] = Node(a[i]);
        for (int i = N - 1; i >= 1; i--) tree[i] = merge(tree[i << 1], tree[i << 1 | 1]);
    }

    // answer sum a[l, r)
    Node query(i64 l, i64 r) {
        Node resl = identity, resr = identity;
        for (l += N - 1, r += N - 1; l < r; l >>= 1, r >>= 1) {
            if (l & 1) resl = merge(resl, tree[l++]);
            if (r & 1) resr = merge(tree[--r], resr);
        }
        return merge(resl, resr);
    }

    // set a[idx] = val
    void set(i64 idx, i64 val) {
        idx += N - 1;
        tree[idx] = Node(val);
        for (idx >>= 1; idx > 0; idx >>= 1) {
            tree[idx] = merge(tree[idx << 1], tree[idx << 1 | 1]);
        }
    }

    // update a[idx] += val
    void update(i64 idx, i64 val) {
        idx += N - 1;
        tree[idx] += Node(val);
        for (idx >>= 1; idx > 0; idx >>= 1) {
            tree[idx] = merge(tree[idx << 1], tree[idx << 1 | 1]);
        }
    }
};

// IterativeSegtree<RangeSum> tree(n, a, RangeSum(), Node(0));
struct RangeSum {
    Node operator()(const Node& a, const Node& b) const {
        return Node(a.val + b.val);
    }
};

// IterativeSegtree<RangeMin> tree(n, a, RangeMin(), Node(2e18));
struct RangeMin {
    Node operator()(const Node& a, const Node& b) const {
        return Node(min(a.val, b.val));
    }
};

// IterativeSegtree<RangeMax> tree(n, a, RangeMax(), Node(-2e18));
struct RangeMax {
    Node operator()(const Node& a, const Node& b) const {
        return Node(max(a.val, b.val));
    };
};

