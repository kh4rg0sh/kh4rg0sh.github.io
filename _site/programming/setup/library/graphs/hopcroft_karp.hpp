#pragma once
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

struct HopcroftKarp {
    static constexpr i64 INF = LLONG_MAX / 4;
    
    // computing maximum bipartite matching
    i64 n, m;
    std::vector<std::vector<i64>> adj;
    std::vector<i64> dist, matchL, matchR;

    // 1-based indexing
    HopcroftKarp(i64 n, i64 m): n(n), m(m) {
        adj.assign(n + 1, {});
        matchL.assign(n + 1, -1);
        matchR.assign(m + 1, -1);
        dist.resize(n + 1);
    }

    void add(i64 u, i64 v) {
        adj[u].push_back(v);
    }

    bool bfs() {
        std::queue<i64> q;
        bool found = false;

        for (int i = 1; i <= n; i++) {
            if (matchL[i] == -1) {
                dist[i] = 0LL;
                q.push(i);
            } else {
                dist[i] = INF;
            }
        }

        while (!q.empty()) {
            i64 u = q.front(); q.pop();
            for (auto v: adj[u]) {
                i64 nxt = matchR[v];
                if (nxt != -1 && dist[nxt] == INF) {
                    dist[nxt] = dist[u] + 1;
                    q.push(nxt);
                }
                if (nxt == -1) {
                    found = true;
                }
            }
        }
        return found;
    }

    bool dfs(i64 u) {
        for (auto v: adj[u]) {
            i64 nxt = matchR[v];
            if (nxt == -1 || (dist[nxt] == dist[u] + 1 && dfs(nxt))) {
                matchL[u] = v;
                matchR[v] = u;
                return true;
            }
        }
        dist[u] = INF;
        return false;
    }

    // use this to get the size of the matching
    i64 compute_size() {
        i64 matching = 0LL;
        while (bfs()) {
            for (int i = 1; i <= n; i++) {
                if (matchL[i] == -1 && dfs(i)) {
                    matching++;
                }
            }
        }
        return matching;
    }

    // use this to get the list of matched edges in matching
    std::vector<std::array<i64, 2>> matching_edges() {
        std::vector<std::array<i64, 2>> edges;
        for (i64 u = 1; u <= n; u++) {
            if (matchL[u] != -1) {
                edges.push_back({u, matchL[u]});
            }
        }
        return edges;
    }

    // konigs theorem
    std::array<std::vector<i64>, 2> minimum_vertex_cover() {
        std::vector<bool> visL(n + 1, false), visR(m + 1, false);
        std::queue<i64> q;

        for (i64 u = 1; u <= n; u++) {
            if (matchL[u] == -1) {
                q.push(u);
                visL[u] = true;
            }
        }

        while (!q.empty()) {
            i64 u = q.front(); q.pop();
            for (auto v: adj[u]) {
                if (matchL[u] != v && !visR[v]) {
                    visR[v] = true;

                    if (matchR[v] != -1 && !visL[matchR[v]]) {
                        visL[matchR[v]] = true;
                        q.push(matchR[v]);
                    }
                }
            }
        }

        std::vector<i64> coverL, coverR;
        for (i64 u = 1; u <= n; u++) {
            if (!visL[u]) coverL.push_back(u);
        }

        for (i64 v = 1; v <= m; v++) {
            if (visR[v]) coverR.push_back(v);
        }

        return {coverL, coverR};
    }
};
