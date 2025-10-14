---
title: I wrote an Euler Tour template
math: true
type: docs
weight: 5
sidebar: 
    open: true
---
probably does not deserve a blog post of it's own, but recently I started encountering a lot of tree problems that can be solved using Euler Tours. Now implementing Euler Tours is not such a big deal. It's just a simple DFS with computation of additional information. However, problems start getting tricky where you just don't have to apply Euler Tours and that adds up to the complexity of the code. As my genius professor said, "A good code is always modular that aims to increase cohesion and reduce coupling", so we'll write our own template for Euler Tours and see how we can use it.

## Design 
I have a preference for `C++ classes` although I know these add much more overhead than `C++ structs`. We'll write a simple class, I don't see the need for writing a class template. There are three important things an Euler Tour computes: `tin`, `tout` and `flattened-tree`. let's make these variables public so that I can directly access these (I hate getter/setters). Now we need to think about the constructor. There are two common use cases that I can think of. Either we have the parents array of the tree or we have the adjacency lists of edges of the tree. So we'll write two constructors to support both of these use cases. Then we need to run a DFS and compute these three quantities. Additionally, we might also want to add a utility function that helps determining ancestor check (this can be done since we have the `tin` and `tout`). Since we already have an ancestor check, we can go ahead and write the LCA

No let's stop there.

I implemented this out (with 1-based indexing) and here's how it looks

{{% details title="Euler Tours Template" closed="true" %}}
```c++
/**
Euler Tours
- pass the tree either as adjacency list or a vector of parent (length n, a[1] = -1/0)
- calculates the euler tour, tin and tout for the graph by a dfs
 */
class EulerTour {
    // euler_tour timer starts from 1
    i64 n;
public:
    std::vector<std::vector<i64>> adj;
    std::vector<i64> par; // should be 1-indexed

    std::vector<i64> euler_tour, tin, tout;

    EulerTour(std::vector<std::vector<i64>>& adj, i64 n): adj(adj), n(n) {
        precompute();
    }

    EulerTour(std::vector<i64>& par): par(par) {
        n = par.size() - 1;
        adj.resize(n + 1, std::vector<i64>());
        for (int i = 2; i <= n; i++) {
            adj[par[i]].push_back(i);
            adj[i].push_back(par[i]);
        }
        precompute();
    }

    void precompute() {
        euler_tour.resize(2 * n + 1, 0);
        tin.resize(n + 1, 0);
        tout.resize(n + 1, 0);

        int timer = 1;
        std::function<void(int, int)> dfs = [&] (int u, int p) -> void {
            euler_tour[timer] = u;
            tin[u] = timer++;
            for (auto v: adj[u]) {
                if (v == p) continue;
                dfs(v, u);
            }
            euler_tour[timer] = u;
            tout[u] = timer++;
            return;
        };

        dfs(1, 0);
    }

    bool is_ancestor(int u, int v) {
        return (tin[u] <= tin[v] && tout[u] >= tout[v]);
    }
};
```
{{% /details %}}

might not really be the most optimal way to do this performance wise, but I used some quick tests to check and this works fine. Now, let's see how we can use this template.

## Problem 1 <a href="https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/A">[Link]</a>
Given a tree and `Q` queries of the form `(u, v)` determine whether `u` is an ancestor of `v` or not (if the tree is rooted at node `1`).

### Solution
Direct application of my template. Infact I added the `is_ancestor` function being inspired from this problem lmfao;

{{% details title="Solution 1" closed="true" %}}
```c++
void yesno(bool ans) {
    if (ans) {
        std::cout << "YES\n";
    } else {
        std::cout << "NO\n";
    }
}

void solve() {
    ll n;
    std::cin >> n;

    std::vector<std::vector<ll>> adj(n + 1);
    for (ll i = 1, x, y; i < n; i++) {
        std::cin >> x >> y;

        adj[x].push_back(y);
        adj[y].push_back(x);
    }

    EulerTour tree(adj, n);

    ll q;
    std::cin >> q;

    for (ll i = 1, x, y; i <= q; i++) {
        std::cin >> x >> y;

        yesno(tree.is_ancestor(x, y));
    }
}
```
{{% /details %}}

## Problem 2 <a href="https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/B">[Link]</a>
Given a tree, print the sizes of subtree rooted at each node. (Assume tree is rooted at node `1`).

### Solution
This is easy, we just have to get the `tin` and `tout` for each node `v` and then divide the length of that  array by `2` which is the size of the subtree rooted at that node `v`. Now that I think of, this could have been computed during the `precompute()` stage of the Euler Tour. It's not a bad idea to comptue these isn't it? Maybe I'll extend the functionality.

```c++
    std::vector<i64> euler_tour, tin, tout, sz; // added sz
    /**
        .
        .
        .
    */
    void computesz() {
        sz.resize(n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            sz[i] = (tout[i] - tin[i] + 1) / 2;
        }
    }
```
man this looks stupid. but anyway, this is useful stuff.

{{% details title="Solution 2" closed="true" %}}
```c++
void solve() {
    ll n;
    std::cin >> n;

    std::vector<std::vector<ll>> adj(n + 1);
    for (ll i = 1, x, y; i < n; i++) {
        std::cin >> x >> y;

        adj[x].push_back(y);
        adj[y].push_back(x);
    }

    EulerTour tree(adj, n);
    tree.computesz();

    for (ll i = 1; i <= n; i++) {
        std::cout << tree.sz[i] << " \n"[i == n];
    }
}
```
{{% /details %}}

## Problem 3 <a href="https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/C">[Link]</a>
You are given a tree rooted at vertex `1`. For each vertex from `1` to `n`, print the sum of values of all nodes in its subtree.

### Solution
Once we have the Euler Tour of the tree, just add the weights `w[u]` and `0` to `tin[u]` and `tout[u]` on the flattened tree. We can then just build prefix sum on this tree and for node `u` answer would be sum from `tin[u]` to `tout[u] - 1`.

You know, maybe it's a good idea to compute this in the class lmfao. Maybe that reduces the clutter we need to do in the main function (good design pattern).

We will call this the `Plus Zero Euler Tour`. I've added these extra functions to support plus zero euler tours
```c++
    std::vector<i64> pz_euler_tour, prefpz; // for plus zero euler tours that add +u to tin[u] && 0 to tout[u]
    /**
        .
        .
        .
    */
    // compute plus zero euler tour
    void computepz() {
        pz_euler_tour.resize(2 * n + 1, 0);
        prefpz.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pz_euler_tour[tin[i]] = i;
            pz_euler_tour[tout[i]] = 0;
        }

        for (ll i = 1; i <= 2 * n; i++) {
            prefpz[i] = prefpz[i - 1] + pz_euler_tour[i];
        }
    }

    // compute plus zero euler tour (custom weights)
    void computepz(std::vector<ll>& a) {
        pz_euler_tour.resize(2 * n + 1, 0);
        prefpz.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pz_euler_tour[tin[i]] = a[i];
            pz_euler_tour[tout[i]] = 0;
        }

        for (ll i = 1; i <= 2 * n; i++) {
            prefpz[i] = prefpz[i - 1] + pz_euler_tour[i];
        }
    }
```
here's how you would use it:
{{% details title="Solution 3" closed="true" %}}
```c++
void solve() {
    ll n;
    std::cin >> n;

    std::vector<ll> a(n + 1, 0);
    for (ll i = 1; i <= n; i++) {
        std::cin >> a[i];
    }

    std::vector<std::vector<ll>> adj(n + 1);
    for (ll i = 1, x, y; i < n; i++) {
        std::cin >> x >> y;

        adj[x].push_back(y);
        adj[y].push_back(x);
    }

    EulerTour tree(adj, n);
    tree.computepz(a);

    for (ll i = 1; i <= n; i++) {
        ll ans = tree.prefpz[tree.tout[i] - 1] - tree.prefpz[tree.tin[i] - 1];
        std::cout << ans << " \n"[i == n];
    }
}
```
{{% /details %}}

## Problem 4 <a href="https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/D">[Link]</a>
You are given a tree rooted at vertex `1`. For each vertex `u` from `1` to `n`, print the maximum sum of a path that starts at vertex `u` and goes downwards in the tree.

### Solution
Now this is where things get interesting. For path queries, it's advisable to use the `Plus Minus Euler Tour` that assigns `+w[u]` to `tin[u]` and `-w[u]` to `tout[u]`. So for any paths that start from node `u` downwards, they are going to be a prefix subarray starting from `tin[u]` with the other endpoint in the range `(tin[u], tout[u])`. Now this is difficult if you don't know about segment trees. Segment tree with storing the maximum prefix and maximum suffix sum can easily solve this and then we just have to query in the range `(tin[u], tout[u])`. 

Now this is where we might want to stop adding more functionalities to the Euler Tour template. I'm still gonna add an additional utility function to compute the plus minus euler tour. so that we don't have to write this clutter out in the main function. 

```c++
    // compute plus minus euler tour
    void computepm() {
        pm_euler_tour.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pm_euler_tour[tin[i]] = i;
            pm_euler_tour[tout[i]] = -i;
        }
    }

    // compute plus minus euler tour (custom weights)
    void computepm(std::vector<ll>& a) {
        pm_euler_tour.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pm_euler_tour[tin[i]] = a[i];
            pm_euler_tour[tout[i]] = -a[i];
        }
    }
```

But for this we will have to write a segment tree. So i'm going to pull out my segment tree template

```c++
class SegmentTree {
    static constexpr i64 inf = 1e18;

    int n;
    struct node {
        i64 sum = 0;
        i64 prefix = -inf;
        i64 suffix = -inf;

        node() {}
        node(i64 val) {
            sum = val;
            prefix = val;
            suffix = val;
        }

        node operator+(const node &other) const {
            node result;
            result.sum = sum + other.sum;
            result.prefix = std::max(prefix, sum + other.prefix);
            result.suffix = std::max(other.suffix, other.sum + suffix);
            return result;
        }
    };
    std::vector<node> tree;
    
    void build_segment_tree(const std::vector<i64>& a, ll v, ll l, ll r) {
        if (l == r) {
            tree[v].sum = a[l];
            tree[v].prefix = a[l];
            tree[v].suffix = a[l];
            return;
        } 

        ll mid = (l + r) >> 1;
        build_segment_tree(a, 2 * v, l, mid);
        build_segment_tree(a, 2 * v + 1, mid + 1, r);
         
        tree[v] = tree[2* v] + tree[2 * v + 1];
    }

    node range_query(i64 v, i64 l, i64 r, i64 tl, i64 tr) {
        if (l > r || r < tl || l > tr) return node();
        if (tl <= l && r <= tr) {
            return tree[v];
        }

        ll mid = (l + r) >> 1;
        return range_query(2 * v, l, mid, tl, tr) +
                        range_query(2 * v + 1, mid + 1, r, tl, tr);
    }

public:
    // keep everything 1-indexed always
    SegmentTree(const std::vector<i64>& a): n(a.size() - 1) {
        tree.resize(4 * n + 3);
        build_segment_tree(a, 1, 1, n);
    }

    i64 range_query(i64 l, i64 r){
        return range_query(1, 1, n, l, r).prefix;
    }
};
```

and then we can solve this problem pretty clean

{{% details title="Solution 4" closed="true" %}}
```c++
void solve() {
    ll n;
    std::cin >> n;

    std::vector<ll> a(n + 1, 0);
    for (ll i = 1; i <= n; i++) {
        std::cin >> a[i];
    }

    std::vector<std::vector<ll>> adj(n + 1);
    for (ll i = 1, x, y; i < n; i++) {
        std::cin >> x >> y;

        adj[x].push_back(y);
        adj[y].push_back(x);
    }

    EulerTour tour(adj, n);
    tour.computepm(a);

    std::vector<ll> pm = tour.pm_euler_tour;
    SegmentTree tree(pm);

    for (ll i = 1; i <= n; i++) {
        ll ans = tree.range_query(tour.tin[i], tour.tout[i] - 1);
        std::cout << ans << " \n"[i == n];
    }
}
```
{{% /details %}}

## A Growing Tree <a href="https://codeforces.com/problemset/problem/1891/F">Codeforces 1891F Round 907 Div. 2 (2000 rated)</a>

![alt text](image.png)

Since we do not have to process these queries online, therefore we can just store all the queries and know the structure of the tree. Once the structure of the tree is constructed, we just have to handle updates to subtree. this can be done by flattening the tree and using any range update data structure (fenwick trees are also a good choice). and when a new node is added, we just have to update that node to 0. this can be again done using a fenwick tree that supports point query and range updates (point query on the node to be updated and then range update on that point to 0).

{{% details title="Solution" closed="true" %}}
```c++
#include <bits/stdc++.h>
#include <numeric>
using namespace std;

#define ll long long
#define i64 long long

const ll MOD1 = 1e9 + 7;
const ll MOD2 = 998244353;

template <typename T>
class FenwickPQRU {
    // this fenwick tree supports point query range increment updates
    i64 n;
    std::vector<T> tree;
public:
    FenwickPQRU(i64 n): n(n) {
        tree.resize(n + 1, 0);
    }

    FenwickPQRU(const std::vector<T>& a): n(a.size() - 1) {
        tree.resize(n + 1, 0);
        for (ll i = 1; i <= n; i++) {
            point_update(i, a[i]);
            point_update(i + 1, -a[i]);
        }
    }

    void point_update(int idx, T val) {
        for (; idx <= n ; idx += idx & -idx) {
            tree[idx] += val;
        }
    }

    void range_update(int l, int r, T val) {
        point_update(l, val);
        point_update(r + 1, -val);
    }

    T point_query(int idx) {
        T result = 0;
        for (; idx > 0; idx -= idx & -idx) {
            result += tree[idx];
        }
        return result;
    }

    void print() {
        for (int i = 1; i <= n; i++) {
            std::cout << tree[i] << " \n"[i == n];
        }
    }
};

using FenwickSumPQRU = FenwickPQRU<i64>;

/**
Euler Tours
- pass the tree either as adjacency list or a vector of parent (length n, a[1] = -1/0)
- calculates the euler tour, tin and tout for the graph by a dfs
 */
class EulerTour {
    // euler_tour timer starts from 1
    i64 n;
public:
    std::vector<std::vector<i64>> adj;
    std::vector<i64> par; // should be 1-indexed
 
    std::vector<i64> euler_tour, tin, tout, sz; // added sz
    std::vector<i64> pz_euler_tour, prefpz; // for plus zero euler tours that add +u to tin[u] && 0 to tout[u]
    std::vector<i64> pm_euler_tour;

    EulerTour(std::vector<std::vector<i64>>& adj, i64 n): adj(adj), n(n) {
        precompute();
    }

    EulerTour(std::vector<i64>& par): par(par) {
        n = par.size() - 1;
        adj.resize(n + 1, std::vector<i64>());
        for (int i = 2; i <= n; i++) {
            adj[par[i]].push_back(i);
            adj[i].push_back(par[i]);
        }
        precompute();
    }

    void precompute() {
        euler_tour.resize(2 * n + 1, 0);
        tin.resize(n + 1, 0);
        tout.resize(n + 1, 0);

        int timer = 1;
        std::function<void(int, int)> dfs = [&] (int u, int p) -> void {
            euler_tour[timer] = u;
            tin[u] = timer++;
            for (auto v: adj[u]) {
                if (v == p) continue;
                dfs(v, u);
            }
            euler_tour[timer] = u;
            tout[u] = timer++;
            return;
        };

        dfs(1, 0);
    }

    // https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/A
    bool is_ancestor(int u, int v) {
        return (tin[u] <= tin[v] && tout[u] >= tout[v]);
    }

    // https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/B
    void computesz() {
        sz.resize(n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            sz[i] = (tout[i] - tin[i] + 1) / 2;
        }
    }

    // https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/C
    // compute plus zero euler tour
    void computepz() {
        pz_euler_tour.resize(2 * n + 1, 0);
        prefpz.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pz_euler_tour[tin[i]] = i;
            pz_euler_tour[tout[i]] = 0;
        }

        for (ll i = 1; i <= 2 * n; i++) {
            prefpz[i] = prefpz[i - 1] + pz_euler_tour[i];
        }
    }

    // compute plus zero euler tour (custom weights)
    void computepz(std::vector<ll>& a) {
        pz_euler_tour.resize(2 * n + 1, 0);
        prefpz.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pz_euler_tour[tin[i]] = a[i];
            pz_euler_tour[tout[i]] = 0;
        }

        for (ll i = 1; i <= 2 * n; i++) {
            prefpz[i] = prefpz[i - 1] + pz_euler_tour[i];
        }
    }

    // https://codeforces.com/group/7Dn3ObOpau/contest/496216/problem/D
    // compute plus minus euler tour
    void computepm() {
        pm_euler_tour.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pm_euler_tour[tin[i]] = i;
            pm_euler_tour[tout[i]] = -i;
        }
    }

    // compute plus minus euler tour (custom weights)
    void computepm(std::vector<ll>& a) {
        pm_euler_tour.resize(2 * n + 1, 0);

        for (ll i = 1; i <= n; i++) {
            pm_euler_tour[tin[i]] = a[i];
            pm_euler_tour[tout[i]] = -a[i];
        }
    }
};

void solve() {
    ll q;
    std::cin >> q;

    std::array<ll, 3> queries[q + 1];
    ll n = 1;
    for (ll i = 1, x; i <= q; i++) {
        std::cin >> x;

        if (x == 1) {
            ll y;
            std::cin >> y;
            n++;

            queries[i] = {1, y, n};
        } else {
            ll y, z;
            std::cin >> y >> z;

            queries[i] = {2, y, z};
        }
    }

    std::vector<std::vector<ll>> adj(n + 1);
    for (ll i = 1; i <= q; i++) {
        if (queries[i][0] == 2) continue;

        adj[queries[i][1]].push_back(queries[i][2]);
        adj[queries[i][2]].push_back(queries[i][1]);
    }

    EulerTour tour(adj, n);

    std::vector<ll> dummy(n + 1, 0);
    tour.computepz(dummy);
    std::vector<ll> f = tour.pz_euler_tour; 

    FenwickSumPQRU fenwick(f);

    for (ll i = 1; i <= q; i++) {
        if (queries[i][0] == 1) {
            ll node = queries[i][2];
            ll pos = tour.tin[node];

            i64 val = fenwick.point_query(pos);
            fenwick.range_update(pos, pos, -val);
        } else {
            ll node = queries[i][1];
            ll val = queries[i][2];

            ll pos1 = tour.tin[node];
            ll pos2 = tour.tout[node];
            fenwick.range_update(pos1, pos2, val);
        }
    }

    for (ll i = 1; i <= n; i++) {
        ll ans = fenwick.point_query(tour.tin[i]);
        std::cout << ans << " \n"[i == n];
    }
}

int main() {
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(0);

    int t = 1;
    std::cin >> t;

    while(t--) {
        solve();
    }
}
```
{{% /details %}}


