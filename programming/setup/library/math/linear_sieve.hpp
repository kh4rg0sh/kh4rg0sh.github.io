#pragma
#include <bits/stdc++.h>

using ll = long long;
using i64 = long long;
using i128 = __int128;

const i64 SIEVE_MAX = 1e9;
const i64 SIEVE_SQRT = 1e7;
 
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
 
i64 binpow(i64 x, i64 y,i64 m) {
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
