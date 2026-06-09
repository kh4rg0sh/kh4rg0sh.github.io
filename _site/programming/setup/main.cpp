#include "library/base/types.hpp"
#include "library/base/constants.hpp"
#include "library/base/helpers.hpp"
#include "library/base/hash.hpp"

void solve() {
    i64 n; cin >> n;

    vector<i64> a(n);
    for (int i = 0; i < n; i++) cin >> a[i];

    bool found = false;
    for (int i = 0; i < (1LL << n); i++) {
        i64 ans = 0;
        for (int j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                ans = (ans + j) % 360;
            } else {
                ans = (ans + 360 - j) % 360;
            }
        }

        if (ans == 0) found = true;
    }

    cf(found);
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
