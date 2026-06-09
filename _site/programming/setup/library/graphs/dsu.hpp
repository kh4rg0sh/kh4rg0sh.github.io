#pragma once
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

struct DSU {
    std::vector<i64> par, sz;

    // 1-based indexing
    DSU(i64 n) {
        par.resize(n + 1, 0LL); 
        sz.resize(n + 1, 1LL);
        for (int i = 1; i <= n; i++) {
            par[i] = i;
        }
    }

    // find the parent of x's component
    i64 find(i64 x) {
        while (x != par[x]) {
            x = par[x] = par[par[x]];
        }
        return x;
    }

    // to get the size of component x belongs to
    i64 size(i64 x) {
        x = find(x);
        return sz[x];
    }

    // check if x and y are in same component
    bool same(i64 x, i64 y) {
        return find(x) == find(y);
    }

    // merge components of x and y
    bool merge(i64 x, i64 y) {
        x = find(x); y = find(y);
        if (x == y) return false;
        if (sz[x] < sz[y]) std::swap(x, y);
        par[y] = x;
        sz[x] += sz[y];
        return true;
    }
};
