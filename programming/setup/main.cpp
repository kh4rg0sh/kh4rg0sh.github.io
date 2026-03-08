#include "library/base/types.hpp"
#include "library/base/constants.hpp"
#include "library/base/helpers.hpp"

#include "library/base/hash.hpp"

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