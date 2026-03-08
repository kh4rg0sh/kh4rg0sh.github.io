#line 2 "library/base/types.hpp"
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

#line 2 "library/base/constants.hpp"
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
#line 3 "library/base/helpers.hpp"

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
#line 4 "main.cpp"

#line 3 "library/base/hash.hpp"

/**
 * usage:
 * unordered_set<i64, custom_hash>
 * unordered_map<i64, i64, custom_hash>
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
 */
// problem: https://codeforces.com/contest/1980/problem/E
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
#line 6 "main.cpp"

void solve() {
    int n;
    cin >> n;

    string s, t;
    cin >> s >> t;

    unordered_map<vector<int>, int, vector_hash<int>> vis;    
    vector<int> start(n + 2, -1), target(n + 2, -1);
    for (int i = 0; i < n; i++) {
        start[i] = (s[i] == 'B') ? 1: 0;
        target[i] = (t[i] == 'B') ? 1: 0;
    }

    int s1 = accumulate(start.begin(), start.end(), 0);
    int s2 = accumulate(target.begin(), target.end(), 0);
    if (s1 != s2) {
        cout << -1 << '\n';
        return;
    }

    vis[start] = 1;
    queue<pair<int, vector<int>>> q;
    q.push({1, start});

    while (q.size()) {
        auto [d, f] = q.front(); q.pop();
        i64 pos = 0;
        for (int i = 0; i <= n; i++) {
            if (f[i] == -1 && f[i + 1] == -1) pos = i;
        }

        for (int i = 0; i <= n; i++) {
            if (f[i] == -1 || f[i + 1] == -1) continue;
            vector<int> next(n + 2);
            for (int j = 0; j < n + 2; j++) {
                next[j] = f[j];
            }

            swap(next[pos], next[i]);
            swap(next[pos + 1], next[i + 1]);
            if (vis[next]) continue;
            vis[next] = d + 1;
            q.push({d + 1, next});
        }
    }

    if (vis[target]) {
        cout << vis[target] - 1 << '\n';
    } else {
        cout << -1 << '\n';
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int t = 1;
    // cin >> t;

    // preprocessing
    // init_sieve();

    while (t--) {
        solve();
    }
}
