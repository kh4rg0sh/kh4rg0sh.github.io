#pragma once
#include "bits/stdc++.h"

using namespace std;
using i64 = long long;

struct mergesorttree {
    struct node {
        i64 l; i64 r;
        vector<array<i64, 2>> p;
        vector<i64> suff;
    };

    i64 n;
    vector<node> a;
    mergesorttree(i64 n, vector<i64>& tin, vector<i64>& tout): n(n) {
        a.resize(4 * n + 5);
        build_segtree(tin, tout, 1, 1, n);
    }

    node combine(node& n1, node& n2) {
        node res;
        i64 l = 0, r = 0;
        while (l < n1.p.size() && r < n2.p.size()) {
            if (n1.p[l][0] < n2.p[r][0]) {
                res.p.push_back(n1.p[l++]);
            } else {
                res.p.push_back(n2.p[r++]);
            }
        }

        while (l < n1.p.size()) res.p.push_back(n1.p[l++]);
        while (r < n2.p.size()) res.p.push_back(n2.p[r++]);

        i64 sz = res.p.size();
        res.suff.resize(sz);
        res.suff[sz - 1] = res.p[sz - 1][1];
        for (int i = sz - 2; i >= 0; i--) {
            res.suff[i] = min(res.p[i][1], res.suff[i + 1]);
        }
        return res;
    }

    void build_segtree(vector<i64>& tin, vector<i64>& tout, i64 ptr, i64 l, i64 r) {
        if (l == r) {
            a[ptr].l = l; a[ptr].r = r;
            a[ptr].p.push_back({tin[l], tout[l]});
            a[ptr].suff.push_back(tout[l]);
            return;
        }

        i64 mid = (l + r) >> 1;
        build_segtree(tin, tout, 2 * ptr, l, mid);
        build_segtree(tin, tout, 2 * ptr + 1, mid + 1, r);
        a[ptr] = combine(a[2 * ptr], a[2 * ptr + 1]);
        a[ptr].l = l; a[ptr].r = r;
    }

    bool find_node(node& res, i64 x, i64 y) {
        auto it = lower_bound(res.p.begin(), res.p.end(), array<i64, 2>{x, LLONG_MIN});
        if (it == res.p.end()) return false;
        i64 pos = it - res.p.begin();
        return res.suff[pos] <= y;
    }

    bool check(i64 x, i64 y, i64 l_, i64 r_, i64 ptr, i64 l, i64 r) {
        if (l > r || l > r_ || r < l_) return false;
        if (l_ <= l && r <= r_) {
            return find_node(a[ptr], x, y);
        }

        i64 mid = (l + r) >> 1;
        if (check(x, y, l_, r_, 2 * ptr, l, mid)) return true;
        if (check(x, y, l_, r_, 2 * ptr + 1, mid + 1, r)) return true;
        return false;
    }

    bool check(i64 x, i64 y, i64 l_, i64 r_) {
        return check(x, y, l_, r_, 1, 1, n);
    }
};