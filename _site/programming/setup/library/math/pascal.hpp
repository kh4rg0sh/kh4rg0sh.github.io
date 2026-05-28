#pragma once
#include <bits/stdc++.h>
using i64 = long long;

/**
 * usage: Pascal pascal(5000, MOD1);
 * usage: pascal.C(n, k);
 * https://atcoder.jp/contests/abc425/tasks/abc425_e
 */
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