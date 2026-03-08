#pragma once
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

template <typename T>
struct Edge {
    i64 from, to;
    T weight;
    i64 id;
};

template<typename T>
struct Node {
    i64 to;
    T weight;
    i64 id;
};

template <typename T = int, bool directed = false>
struct Graph {
    static constexpr bool is_directed = directed;
    // vertices and edges
    i64 n, m;
    Graph(): n(0), m(0) {}
    Graph(i64 n): n(n), m(0) {}

    using weight_type = T;
    using edge_type = Edge<T>;
    using node_type = Node<T>;
    std::vector<edge_type> edges;

    // assume 1-based indexing here
    void add_edge(i64 from, i64 to, T weight = -1) {
        assert(1 <= from && from <= n && 1 <= to && to <= n);
        auto edge = edge_type({from, to, weight, m});
        edges.emplace_back(edge); m++;
    }

    // construct neighbour list
    std::vector<std::vector<node_type>> adj;
    std::vector<i64> degree;
    void build() {
        adj.resize(n + 1);
        for (auto& edge: edges) {
            auto node = node_type({edge.to, edge.weight, edge.id});
            adj[edge.from].emplace_back(node);

            if (!directed) {
                auto reverse_node = node_type({edge.from, edge.weight, edge.id});
                adj[edge.to].emplace_back(reverse_node);
            }
        }
    }

};

