#pragma once
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

struct Kosaraju {
    // for the scc graph
    i64 idx = 1;
    std::map<i64, i64> scc_idx;
    std::map<i64, std::vector<i64>> scc_comp;
    std::vector<std::vector<i64>> scc_edges;
    std::vector<i64> in, out;

    // for toposort
    std::vector<i64> start, finish, toposort;

    // 1-based indexing
    Kosaraju(
        i64 n, 
        std::vector<std::vector<i64>> adj
    ) {
        std::vector<std::vector<i64>> adjr(n + 1);
        for (int i = 1; i <= n; i++) {
            for (auto u: adj[i]) {
                adjr[u].push_back(i);
            }
        }

        start.resize(n + 1, 0LL);
        finish.resize(n + 1, 0LL);
        std::vector<bool> vis(n + 1, false);
        i64 timer = 1;

        std::function<void(i64)> dfs = [&] (i64 u) -> void {
            start[u] = timer++;
            vis[u] = true;
            for (auto v: adj[u]) {
                if (vis[v]) continue;
                dfs(v);
            }
            finish[u] = timer++;
            toposort.push_back(u);
            return;
        };

        for (int i = 1; i <= n; i++) {
            if (vis[i]) continue;
            dfs(i);
        }
 
        std::reverse(toposort.begin(), toposort.end());
        for (int i = 1; i <= n; i++) {
            vis[i] = false;
        }

        std::function<void(i64)> dfsr = [&] (i64 u) -> void {
            vis[u] = true;
            scc_idx[u] = idx;
            scc_comp[idx].push_back(u);
            for (auto v: adjr[u]) {
                if (vis[v]) continue;
                dfsr(v);
            }
            return;
        };
    
        for (auto u: toposort) {
            if (vis[u]) continue;
            dfsr(u);
            idx++;
        }
    }

    // use this to construct the SCC DAG
    void construct(const std::map<std::array<i64, 2>, bool>& edges) {
        in.resize(idx);
        out.resize(idx);
        scc_edges.resize(idx);

        for (auto [u, v]: edges) {
            i64 l1 = scc_idx[u[0]];
            i64 l2 = scc_idx[u[1]];
            if (l1 == l2) continue;
            out[l1]++;
            in[l2]++;
            scc_edges[l1].push_back(l2);
        }
    }
};
