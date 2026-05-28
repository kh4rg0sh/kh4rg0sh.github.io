#pragma once
#include "base.hpp"

template <typename Graph>
struct TwoEdgeConnectedComponent {
    // get the graph by reference
    Graph& G;
    using node_type = typename Graph::node_type;

    // assume 1-based indexing everywhere
    i64 n;
    std::vector<i64> tin, low;
    std::vector<bool> is_bridge;
    TwoEdgeConnectedComponent(Graph& G): G(G) {
        n = G.n;
        is_bridge.assign(G.m, false);
        tin.assign(n + 1, -1);
        low.assign(n + 1, -1);
        build();
    }

    std::vector<i64> comp;
    i64 timer = 0, comp_count = 0;

    void dfs_bridge(i64 v, i64 peid = -1) {
        tin[v] = low[v] = timer++;
        for (auto& edge: G.adj[v]) {
            i64 to = edge.to;
            i64 id = edge.id;

            if (id == peid) continue;
            if (tin[to] == -1) {
                dfs_bridge(to, id);
                low[v] = std::min(low[v], low[to]);

                if (low[to] > tin[v]) {
                    is_bridge[id] = true;
                }
            } else {
                low[v] = std::min(low[v], tin[to]);
            }
        }
    }

    void dfs_comp(i64 v) {
        comp[v] = comp_count;
        for (auto& edge: G.adj[v]) {
            i64 to = edge.to;
            i64 id = edge.id;

            if (comp[to] != -1) continue;
            if (is_bridge[id]) continue;
            dfs_comp(to);
        }
    }

    void build() {
        for (int i = 1; i <= n; i++) {
            if (tin[i] == -1) {
                dfs_bridge(i);
            }
        }

        comp.assign(n + 1, -1);
        for (int i = 1; i <= n; i++) {
            if (comp[i] == -1) {
                dfs_comp(i);
                comp_count++;
            }
        }
    }

    // problem: https://judge.yosupo.jp/problem/two_edge_connected_components
    // submission: https://judge.yosupo.jp/submission/357898
    std::vector<std::vector<i64>> decompose() {
        std::vector<std::vector<i64>> component(comp_count);
        for (int i = 1; i <= n; i++) {
            component[comp[i]].push_back(i);
        }
        return component;
    }

};

