#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using i64 = long long;
using i128 = __int128;

#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <ext/pb_ds/detail/standard_policies.hpp>

using namespace __gnu_pbds;
typedef tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update> ordered_set;
typedef tree<std::pair<int, int>, null_type, less<std::pair<int, int>>, rb_tree_tag, tree_order_statistics_node_update> ordered_set_pair;

typedef tree<i64, null_type, less<i64>, rb_tree_tag, tree_order_statistics_node_update> ordered_set_64;
typedef tree<std::pair<i64, i64>, null_type, less<std::pair<i64, i64>>, rb_tree_tag, tree_order_statistics_node_update> ordered_set_pair_64;

std::istream& operator>>(std::istream& iss, i128& n) {
    std::string s;
    iss >> s;
    n = 0;

    for (int i = (s[0] == '-'); i < s.size(); i++) {
        n = n * 10 + (s[i] - '0');
    }

    if (s[0] == '-') n = -n;
    return iss;
}

std::ostream& operator<<(std::ostream& oss, i128 n) {
    if (n == 0) return oss << "0";

    std::string s;
    if (n < 0) {
        s += '-';
        n = -n;
    }

    while (n) {
        s += '0' + n % 10;
        n /= 10;
    }

    std::reverse(s.begin() + (s[0] == '-'), s.end());
    return oss << s;
}

static const long long pow2[] = { 
    1LL, 2LL, 4LL, 8LL, 16LL, 32LL, 64LL, 128LL, 256LL, 512LL, 1024LL, 2048LL, 4096LL, 8192LL, 16384LL, 32768LL, 65536LL, 131072LL, 262144LL, 524288LL, 1048576LL, 2097152LL, 4194304LL, 8388608LL, 16777216LL, 33554432LL, 67108864LL, 134217728LL, 268435456LL, 536870912LL, 1073741824LL, 2147483648LL, 4294967296LL, 8589934592LL, 17179869184LL, 34359738368LL, 68719476736LL, 137438953472LL, 274877906944LL, 549755813888LL, 1099511627776LL, 2199023255552LL, 4398046511104LL, 8796093022208LL, 17592186044416LL, 35184372088832LL, 70368744177664LL, 140737488355328LL, 281474976710656LL, 562949953421312LL, 1125899906842624LL, 2251799813685248LL, 4503599627370496LL, 9007199254740992LL, 18014398509481984LL, 36028797018963968LL, 72057594037927936LL, 144115188075855872LL, 288230376151711744LL, 576460752303423488LL
};
static const long long pow3[] = {
    1LL, 3LL, 9LL, 27LL, 81LL, 243LL, 729LL, 2187LL, 6561LL, 19683LL, 59049LL, 177147LL, 531441LL, 1594323LL, 4782969LL, 14348907LL, 43046721LL, 129140163LL, 387420489LL, 1162261467LL, 3486784401LL, 10460353203LL, 31381059609LL, 94143178827LL, 282429536481LL, 847288609443LL, 2541865828329LL, 7625597484987LL, 22876792454961LL, 68630377364883LL, 205891132094649LL, 617673396283947LL, 1853020188851841LL, 5559060566555523LL, 16677181699666569LL, 50031545098999707LL, 150094635296999121LL, 450283905890997363LL
};
static const long long pow5[] = {
    1LL, 5LL, 25LL, 125LL, 625LL, 3125LL, 15625LL, 78125LL, 390625LL, 1953125LL, 9765625LL, 48828125LL, 244140625LL, 1220703125LL, 6103515625LL, 30517578125LL, 152587890625LL, 762939453125LL, 3814697265625LL, 19073486328125LL, 95367431640625LL, 476837158203125LL, 2384185791015625LL, 11920928955078125LL, 59604644775390625LL, 298023223876953125LL, 1490116119384765625LL
};
static const long long pow10[] = {
    1LL, 10LL, 100LL, 1000LL, 10000LL, 100000LL, 1000000LL, 10000000LL, 100000000LL, 1000000000LL, 10000000000LL, 100000000000LL, 1000000000000LL, 10000000000000LL, 100000000000000LL, 1000000000000000LL, 10000000000000000LL, 100000000000000000LL, 1000000000000000000LL
};

const i64 MOD1 = 1e9 + 7;
const i64 MOD2 = 998244353;
const i64 LARGE = 1e17;

void cf(bool value) {
    if (value) {
        std::cout << "YES\n";
    } else {
        std::cout << "NO\n";
    }
}

void atc(bool value) {
    if (value) {
        std::cout << "Yes\n";
    } else {
        std::cout << "No\n";
    }
}

template<typename T>
void read_vector(vector<T>& vec, i64 n) {
    for (int i = 1; i <= n; i++) cin >> vec[i];
}

template<typename T>
void read_vector_zero(vector<T>& vec, i64 n) {
    for (int i = 0; i < n; i++) cin >> vec[i];
}

/**
 * usage:
 * unordered_set<i64, custom_hash>
 * unordered_map<i64, i64, custom_hash>
 * // problem: https://atcoder.jp/contests/abc448/tasks/abc448_d
 */
struct custom_hash {
    static uint64_t splitmix64(uint64_t x) {
        x += 0x9e3779b97f4a7c15;
        x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;
        x = (x ^ (x >> 27)) * 0x94d049bb133111eb;
        return x ^ (x >> 31);
    }

    size_t operator()(uint64_t x) const {
        static const uint64_t RANDOM =
            std::chrono::steady_clock::now().time_since_epoch().count();
        return splitmix64(x + RANDOM);
    }
};

/**
 * usage:
 * unordered_set<pair<i64, i64>, pair_hash<i64, i64>>
 */
template<class T, class U>
struct pair_hash {
    size_t operator()(const std::pair<T,U>& p) const {
        uint64_t h1 = custom_hash::splitmix64((uint64_t)p.first);
        uint64_t h2 = custom_hash::splitmix64((uint64_t)p.second);
        return custom_hash::splitmix64(h1 ^ (h2 << 1));
    }
};

/**
 * usage:
 * unordered_set<vector<i64>, vector_hash<i64>>
 * // problem: https://codeforces.com/contest/1980/problem/E
 * 
 * unordered_map<vector<int>, int, vector_hash<int>>
 * // problem: https://atcoder.jp/contests/abc361/tasks/abc361_d
 */

template<class T>
struct vector_hash {
    size_t operator()(const std::vector<T>& v) const {
        static const uint64_t RANDOM =
            std::chrono::steady_clock::now().time_since_epoch().count();

        uint64_t h = RANDOM;
        for (auto &x : v) {
            uint64_t y = custom_hash::splitmix64((uint64_t)x);
            h = custom_hash::splitmix64(h ^ y);
        }

        return h;
    }
};

/**
 * usage:
 * unordered_set<tuple<int,int,int>, tuple_hash>
 */
struct tuple_hash {
    template<class... T>
    size_t operator()(const std::tuple<T...>& t) const {
        return apply([](const auto&... args) {
            uint64_t h = 0;
            ((h = custom_hash::splitmix64(h ^
                custom_hash::splitmix64((uint64_t)args))), ...);
            return h;
        }, t);
    }
};

struct DSU {
    std::vector<i64> par, sz, color;

    // 1-based indexing
    DSU(i64 n) {
        par.resize(n + 1, 0LL); 
        sz.resize(n + 1, 1LL);
        color.resize(n + 1, 0LL);
        for (int i = 1; i <= n; i++) {
            par[i] = i;
            color[i] = i;
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

    bool merge_without_swap(i64 x, i64 y) {
        x = find(x); y = find(y);
        if (x == y) return false;
        par[y] = x;
        sz[x] += sz[y];
        return true;
    }
};

struct DSUParity {
    std::vector<i64> par, sz, color;
    std::vector<i64> parity, black, white;

    // parity => 0 if relative color wrt leader is same
    // else 1

    // 1-based indexing
    DSUParity(i64 n) {
        par.resize(n + 1, 0LL); 
        sz.resize(n + 1, 1LL);
        color.resize(n + 1, 0LL);
        parity.resize(n + 1, 0LL);
        black.resize(n + 1, 0LL);
        white.resize(n + 1, 1LL);
        for (int i = 1; i <= n; i++) {
            par[i] = i;
            color[i] = i;
        }
    }

    // find the parent of x's component
    pair<i64, i64> find(i64 x) {
        if (par[x] == x) return {x, 0};
        auto [l, p] = find(par[x]);
        parity[x] ^= p; par[x] = l;
        return {l, parity[x]};
    }

    // to get the size of component x belongs to
    i64 size(i64 x) {
        auto [xx, p] = find(x);
        return sz[xx];
    }

    // check if x and y are in same component
    bool same(i64 x, i64 y) {
        return find(x).first == find(y).first;
    }

    // merge components of x and y
    bool merge(i64 x, i64 y) {
        auto [lx, px] = find(x);
        auto [ly, py] = find(y);
        if (lx == ly) return false;
        if (sz[lx] < sz[ly]) {
            swap(lx, ly);
            swap(px, py);
        }
        
        // update the ds now
        par[ly] = lx;
        sz[lx] += sz[ly];
        parity[ly] = py ^ px ^ 1;

        if (parity[ly] == 0) {
            black[lx] += black[ly];
            white[lx] += white[ly];
        } else {
            black[lx] += white[ly];
            white[lx] += black[ly];
        }
        return true;
    }
};

struct Kosaraju {
    // for the scc graph
    i64 idx = 1;
    std::map<i64, i64> scc_idx; // what scc index does it belong
    std::map<i64, std::vector<i64>> scc_comp; // get vertices in scc comp by scc index
    std::vector<std::vector<i64>> scc_edges; // scc adj list
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

const i64 SIEVE_MAX = 1e9;
const i64 SIEVE_SQRT = 100;
 
i64 lp[SIEVE_SQRT + 1];
std::vector<i64> prs;
 
void init_sieve() {
    for (i64 i = 2; i <= SIEVE_SQRT; i++) {
        if (lp[i] == 0) {
            lp[i] = i;
            prs.push_back(i);
        }
        for (i64 j = 0; i * prs[j] <= SIEVE_SQRT; j++) {
            lp[i * prs[j]] = prs[j];
            if (prs[j] == lp[i]) break;
        }
    }
}

/**
Mod Int template:
1. to be used for counting problems (problems with too many modular operations)
2. constructors:
  - default constructor
  - 1-arg constructor
3. modint functions:
  - plus, minus, multiplication operator (binary and assignment)
  - stream operators
 */
template <i64 Z>
struct modint {
private:
    static i64 norm(i64 x_val) {
        if (x_val < 0) {
            x_val += Z;
        }
        if (x_val >= Z) {
            x_val -= Z;
        }
        return x_val;
    }
    i64 power(i64 a, i64 b) const {
        i64 res = 1;
        for (; b; b /= 2, a = (a * a) % Z) {
            if (b % 2) {
                res = (res * a) % Z;
            }
        }
        return res;
    }

public:
    i64 x; // the actual number

    // modint constructors
    modint(): x(0) {}
    modint(i64 x_val): x(norm(x_val % Z)) {} 

    // modint functions
    // 1. unary negative
    modint operator-() const {
        return modint(norm(Z - x));
    }
    // 2. operation assignment
    modint& operator=(i64 val) {
        x = norm(val % Z);
        return *this;
    }
    modint& operator+=(const modint& other) {
        x = norm(x + other.x);
        return *this;
    }
    modint& operator+=(i64 val) {
        x = norm((x + val) % Z);
        return *this;
    }
    modint& operator-=(const modint& other) {
        x = norm(x - other.x);
        return *this;
    }
    modint& operator-=(i64 val) {
        x = norm((x - val) % Z);
        return *this;
    }
    modint& operator*=(const modint& other) {
        x = (x * other.x) % Z;
        return *this;
    }
    modint& operator*=(i64 val) {
        x = (x * (val % Z)) % Z;
        x = norm(x);
        return *this;
    }
    bool operator==(const modint& other) const {
        return x == other.x;
    }
    bool operator!=(const modint& other) const {
        return !(*this == other);
    }
    // 3. modular inverse
    modint inv() const {
        return modint(power(x, Z - 2));
    }
    modint& operator/=(const modint& other) {
        x = (x * other.inv().x) % Z;
        return *this;
    }
    // 4. binary operators
    friend modint operator+(modint first, const modint& second) {
        first += second;
        return first;
    }
    friend modint operator+(i64 val, modint first) {
        first += val;
        return first;
    }
    friend modint operator+(modint first, i64 val) {
        first += val;
        return first;
    }
    friend modint operator-(modint first, const modint& second) {
        first -= second;
        return first;
    }
    friend modint operator-(modint first, i64 val) {
        first -= val;
        return first;
    }
    friend modint operator*(modint first, const modint& second) {
        first *= second;
        return first;
    }
    friend modint operator*(modint first, i64 val) {
        first *= val;
        return first;
    }
    friend modint operator*(i64 val, modint first) {
        first *= val;
        return first;
    }
    friend modint operator/(modint first, const modint& second) {
        first /= second;
        return first;
    }
    // 5. stream operators
    friend std::istream& operator>>(std::istream& iss, modint& a) {
        i64 result;
        iss >> result;
        a = modint(result);
        return iss;
    }
    friend std::ostream& operator<<(std::ostream& oss, const modint& a) {
        return oss << a.x;
    }
};

using z1 = modint<MOD1>;
using z2 = modint<MOD2>;

i64 binpow(i64 x, i64 y, i64 m) {
    x %= m;
    i64 result = 1;
 
    while (y > 0) {
        if (y & 1) result = result * x % m;
        x = x * x % m;
        y >>= 1;
    }
 
    result %= m;
    return result;
}
 
i64 modinv(i64 x, i64 p) {
    return binpow(x, p - 2, p);
}

template<typename T>
T binpow(T x, i64 y) {
    T result = 1;
    while (y > 0) {
        if (y & 1) result = result * x;
        x = x * x;
        y >>= 1;
    }
    return result;
}

struct Pascal {
    i64 N, M = -1;
    std::vector<std::vector<i64>> binom;

    Pascal(i64 N, i64 M = -1): N(N), M(M) {
        binom.resize(N + 1, std::vector<i64>(N + 1));
        compute();
    }

    void compute() {
        for (int i = 0; i <= N; i++) {
            binom[i][0] = 1;
            binom[i][i] = 1;
        }

        for (int i = 1; i <= N; i++) {
            for (int j = 1; j < i; j++) {
                i64 ans = binom[i - 1][j] + binom[i - 1][j - 1];
                if (M != -1) ans %= M;
                binom[i][j] = ans;
            }
        }
    }   

    i64 C(i64 n, i64 k) {
        if (k < 0 || k > n) return 0;
        return binom[n][k];
    }
};

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

i64 isqrt(i64 x) {
    i64 r = sqrtl(x);
    while ((r + 1) * (r + 1) <= x) r++;
    while (r * r > x) r--;
    return r;
}

struct binomial {
    void copy() {
        i64 n;
        i64 fact[n + 1], invfact[n + 1];
        fact[0] = 1; invfact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (i * fact[i - 1]) % MOD2;
        }

        invfact[n] = modinv(fact[n], MOD2);
        for (int i = n - 1; i > 0; i--) {
            invfact[i] = (invfact[i + 1] * (i + 1)) % MOD2;
        }

        auto coeff = [&] (i64 x, i64 y) -> i64 {
            if (x < y || y < 0) return 0;
            i64 ans = 1;
            ans = (ans * fact[x]) % MOD2;
            ans = (ans * invfact[y]) % MOD2;
            ans = (ans * invfact[x - y]) % MOD2;
            return ans;
        };
    }

    void modcopy() {
        const i64 N = 2000;
        z2 fact[N + 1], invfact[N + 1];
        fact[0] = 1; invfact[0] = 1;
        for (int i = 1; i <= N; i++) {
            fact[i] = fact[i - 1] * i;
        }

        invfact[N] = 1 / fact[N];
        for (int i = N - 1; i > 0; i--) {
            invfact[i] = invfact[i + 1] * (i + 1);
        }

        auto coeff = [&] (i64 x, i64 y) -> z2 {
            if (x < y || y < 0) return 0;
            z2 ans = fact[x] * invfact[y] * invfact[x - y];
            return ans;
        };
    }
};

struct MergeSortTree_EulerTour {
    struct MergeSortNode {
        vector<i64> sorted; // sorted by x
        vector<i64> suff; // suff minima of y
    };

    i64 n;
    vector<MergeSortNode> a;
    MergeSortTree_EulerTour(i64 n, vector<i64>& tin, vector<i64>& tout): n(n) {
        a.resize(4 * n + 5);
        build_tree(tin, tout, 1, 1, n);
    }

    MergeSortNode combine(MergeSortNode n1, MergeSortNode n2) {
        MergeSortNode res;
        i64 l = 0, r = 0;
        while (l < n1.sorted.size() && r < n2.sorted.size()) {
            if (n1.sorted[l] < n2.sorted[r]) {
                res.sorted.push_back(n1.sorted[l++]);
            } else {
                res.sorted.push_back(n2.sorted[r++]);
            }
        }

        while (l < n1.sorted.size()) res.sorted.push_back(n1.sorted[l++]);
        while (r < n2.sorted.size()) res.sorted.push_back(n2.sorted[r++]);

        i64 len = res.sorted.size();
        res.suff.resize(len);
        res.suff[len - 1] = res.sorted[len - 1];
        for (int i = len - 2; i >= 0; i--) {
            res.suff[i] = min(res.suff[i + 1], res.sorted[i]);
        }
        return res;
    }

    void build_tree(vector<i64>& tin, vector<i64>& tout, i64 v, i64 l, i64 r) {
        if (l == r) {
            a[v].sorted.push_back(tin[l]);
            a[v].suff.push_back(tout[l]);
            return;
        }

        i64 mid = (l + r) >> 1;
        build_tree(tin, tout, 2 * v, l, mid);
        build_tree(tin, tout, 2 * v + 1, mid + 1, r);
        a[v] = combine(a[2 * v], a[2 * v + 1]);
    }

    bool exists(MergeSortNode& res, i64 x, i64 y) {
        auto it = lower_bound(res.sorted.begin(), res.sorted.end(), x);
        if (it == res.sorted.end()) return false;

        i64 pos = it - res.sorted.begin();
        return res.suff[pos] <= y;
    }

    bool check(i64 x, i64 y, i64 l, i64 r, i64 v, i64 L, i64 R) {
        if (L > R || L > r || R < l) return false;
        if (l <= L && R <= r) {
            return exists(a[v], x, y);
        }

        i64 mid = (L + R) >> 1;
        if (check(x, y, l, r, 2 * v, L, mid)) return true;
        if (check(x, y, l, r, 2 * v + 1, mid + 1, R)) return true;
        return false;
    }

    bool check(i64 x, i64 y, i64 l, i64 r) {
        return check(x, y, l, r, 1, 1, n);
    }
};

struct Node {
    i64 val = 0;
    Node(i64 v = 0): val(v) {}
    Node& operator=(i64 v) {
        val = v;
        return *this;
    }
    Node& operator+=(i64 v) {
        val += v;
        return *this;
    }
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

    IterativeSegtree(i64 n, const vector<i64>& a,
                    Merge merge,
                    Node identity): N(n), merge(merge), identity(identity) {
        tree.assign(2 * N + 1, identity);
        construct(a);
    }

    void construct(const vector<i64>& a) {
        for (int i = 1; i <= N; i++) tree[i + N - 1] = a[i];
        for (int i = N - 1; i >= 1; i--) tree[i] = merge(tree[i << 1], tree[i << 1 | 1]);
    }

    // answer sum a[l, r)
    i64 query(i64 l, i64 r) {
        Node resl = identity, resr = identity;
        for (l += N - 1, r += N - 1; l < r; l >>= 1, r >>= 1) {
            if (l & 1) resl = merge(resl, tree[l++]);
            if (r & 1) resr = merge(tree[--r], resr);
        }
        return merge(resl, resr).val;
    }

    // set a[idx] = val
    void set(i64 idx, i64 val) {
        idx += N - 1;
        tree[idx] = val;
        for (idx >>= 1; idx > 0; idx >>= 1) {
            tree[idx] = merge(tree[idx << 1], tree[idx << 1 | 1]);
        }
    }

    // update a[idx] += val
    void update(i64 idx, i64 val) {
        idx += N - 1;
        tree[idx] += val;
        for (idx >>= 1; idx > 0; idx >>= 1) {
            tree[idx] = merge(tree[idx << 1], tree[idx << 1 | 1]);
        }
    }

    // find the first r >= l such that predicate is false on [l, r]
    i64 partition_point(i64 l, function<bool(const Node&)> pred) {
        Node pref = identity;
        i64 idx = l + N - 1;

        while (true) {
            while ((idx & 1) == 0) idx >>= 1;
            Node next = merge(pref, tree[idx]);
            if (!pred(next)) break;

            pref = next;
            idx++;

            if ((idx & (idx - 1)) == 0) return N + 1;
        }

        while (idx < N) {
            idx <<= 1;
            Node next = merge(pref, tree[idx]);
            if (pred(next)) {
                pref = next;
                idx++;
            }
        }

        return idx - (N - 1);
    }

    i64 find_first(i64 l, function<bool(i64)> pred) {
        return partition_point(l, [&](const Node& nd) {
            return pred(nd.val);
        });
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

void debug_later() {
    i64 n, x, y;
    cin >> n >> x >> y;

    vector<i64> a(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }

    i64 ans = 0;
    IterativeSegtree<RangeMin> tree1(n, a, RangeMin(), Node(2e18));
    IterativeSegtree<RangeMax> tree2(n, a, RangeMax(), Node(-2e18));

    // https://atcoder.jp/contests/abc247/tasks/abc247_e
    for (int i = 1; i <= n; i++) {
        i64 lm = tree1.find_first(i, [&](i64 val) { return val > y; });
        i64 rm = tree1.find_first(i, [&](i64 val) { return val <= y; }) - 1;
        i64 lM = tree2.find_first(i, [&](i64 val) { return val < x; });
        i64 rM = tree2.find_first(i, [&](i64 val) { return val >= x; }) - 1;
        i64 L = max(lm, lM);
        i64 R = min(rm, rM);
        if (L > R) continue;
        ans += (R - L + 1);
    }
    cout << ans << '\n';
} 

struct StringHash {
    ll B;
    static const ll MOD = (1LL << 61) - 1;

    int n;
    std::string s;
    std::vector<ll> pow, hash1, hash2;

    // everything is 0-indexed here
    StringHash(const string &str) {
        s = str;
        n = s.size();
        pow.resize(n + 1);
        hash1.resize(n + 1);
        hash2.resize(n + 1);

        mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());
        uniform_int_distribution<ll> dist(256, 1000000000);
        B = dist(rng);

        pow[0] = 1;
        for (int i = 1; i <= n; ++i)
            pow[i] = modmul(pow[i - 1], B);

        for (int i = 0; i < n; ++i) {
            hash1[i + 1] = modadd(modmul(hash1[i], B), s[i]);
            hash2[i + 1] = modadd(modmul(hash2[i], B), s[n - 1 - i]);
        }
    }

    static ll modmul(ll a, ll b) {
        __int128_t t = (__int128_t)a * b;
        t = (t >> 61) + (t & MOD);
        if (t >= MOD) t -= MOD;
        return (ll)t;
    }

    static ll modadd(ll a, ll b) {
        ll res = a + b;
        if (res >= MOD) res -= MOD;
        return res;
    }

    ll get_hash(int l, int r) {
        ll val = hash1[r + 1] + MOD - modmul(hash1[l], pow[r - l + 1]);
        if (val >= MOD) val -= MOD;
        return val;
    }

    ll get_revhash(int l, int r) {
        ll val = hash2[r + 1] + MOD - modmul(hash2[l], pow[r - l + 1]);
        if (val >= MOD) val -= MOD;
        return val;
    }

    bool check_palindrome(int l, int r) {
        int rl = n - 1 - r;
        int rr = n - 1 - l;
        return get_hash(l, r) == get_revhash(rl, rr);
    }
};

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

void solve() {
    i64 n; cin >> n;
    string s; cin >> s;

    bool found = false;
    
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int t = 1; 
    // cin >> t;

    // preprocessing
    // init_sieve();

    bool debug = false;
    if (!debug) {
        while (t--) {
            solve();
        }
    } else {

    }
}