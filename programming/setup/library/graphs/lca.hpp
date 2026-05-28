#pragma once
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

struct LCA {
    i64 n, sz;
    std::vector<std::vector<std::array<i64, 2>>>  adj;
    std::map<std::array<i64, 2>, i64> mp;

    std::vector<std::vector<i64>> dp, maxdp, mindp;
    std::vector<i64> tin, tout, par;
    LCA(i64 n, std::vector<std::vector<std::array<i64, 2>>>& adj, 
            std::map<std::array<i64, 2>, i64>& mp): 
                n(n), adj(adj), mp(mp) {
        tin.resize(n + 1);
        tout.resize(n + 1);
        par.resize(n + 1);
        sz = (i64)std::log2(n) + 1;
        compute();
    }

    bool is_ancestor(i64 u, i64 v) {
        return (tin[u] <= tin[v]) && (tout[u] >= tout[v]);
    }

    void compute() {
        i64 timer = 1;
        auto dfs = [&] (auto&& self, i64 u, i64 p) -> void {
            par[u] = p;
            tin[u] = timer++;
            for (auto [v, ln]: adj[u]) {
                if (v == p) continue;
                self(self, v, u);
            }
            tout[u] = timer++;
        };
        dfs(dfs, 1, -1);

        dp.resize(n + 1, std::vector<i64>(sz, -1LL));
        binary_lift_lca();

        mindp.resize(n + 1, std::vector<i64>(sz, (i64)1e18));
        binary_lift_min();

        maxdp.resize(n + 1, std::vector<i64>(sz, 0LL));
        binary_lift_max();
    }

    void binary_lift_lca() {
        for (int j = 0; j < sz; j++) {
            for (int i = 1; i <= n; i++) {
                if (j == 0) {
                    dp[i][j] = par[i];
                } else {
                    if (dp[i][j - 1] == -1) dp[i][j] = -1;
                    else dp[i][j] = dp[dp[i][j - 1]][j - 1];
                }
            }
        }
    }

    void binary_lift_min() {
        for (int j = 0; j < sz; j++) {
            for (int i = 1; i <= n; i++) {
                if (j == 0) {
                    if (dp[i][j] == -1) mindp[i][j] = 1e18;
                    else mindp[i][j] = mp[{i, dp[i][j]}];
                } else {
                    if (dp[i][j - 1] == -1) mindp[i][j] = mindp[i][j - 1];
                    else mindp[i][j] = std::min(mindp[i][j - 1],
                                            mindp[dp[i][j - 1]][j - 1]);
                }
            }
        }
    }

    void binary_lift_max() {
        for (int j = 0; j < sz; j++) {
            for (int i = 1; i <= n; i++) {
                if (j == 0) {
                    if (dp[i][j] == -1) maxdp[i][j] = 0;
                    else maxdp[i][j] = mp[{i, dp[i][j]}];
                } else {
                    if (dp[i][j - 1] == -1) maxdp[i][j] = maxdp[i][j - 1];
                    else maxdp[i][j] = std::max(maxdp[i][j - 1],
                                            maxdp[dp[i][j - 1]][j - 1]);
                }
            }
        }
    }

    i64 lca(i64 u, i64 v) {
        if (is_ancestor(u, v)) return u;
        if (is_ancestor(v, u)) return v;
        for (int i = sz - 1; i >= 0; --i) {
            if (dp[u][i] == -1) continue;
            if (!is_ancestor(dp[u][i], v)) {
                u = dp[u][i];
            }
        }
        return dp[u][0];
    }

    i64 lenmax(i64 u, i64 v) {
        if (u == v) return 0;
        i64 ans = 0;
        for (int i = sz - 1; i >= 0; --i) {
            if (dp[u][i] == -1) continue;
            if (!is_ancestor(dp[u][i], v)) {
                ans = std::max(ans, maxdp[u][i]);
                u = dp[u][i];
            }
        }
        if (par[u] != -1) ans = std::max(ans, mp[{u, par[u]}]);
        return ans;
    }

    i64 pathmax(i64 u, i64 v) {
        if (u == v) return 0;
        i64 w = lca(u, v);
        return std::max(lenmax(u, w), lenmax(v, w));
    }

    i64 lenmin(i64 u, i64 v) {
        if (u == v) return (i64)1e18;
        i64 ans = 1e18;
        for (int i = sz - 1; i >= 0; --i) {
            if (dp[u][i] == -1) continue;
            if (!is_ancestor(dp[u][i], v)) {
                ans = std::min(ans, mindp[u][i]);
                u = dp[u][i];
            }
        }
        if (par[u] != -1) ans = std::min(ans, mp[{u, par[u]}]);
        return ans;
    }

    i64 pathmin(i64 u, i64 v) {
        if (u == v) return 0;
        i64 w = lca(u, v);
        return std::min(lenmin(u, w), lenmin(v, w));
    }
};