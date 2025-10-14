---
title: Sparse Table
math: true
type: docs
weight: 5
---

Sparse Table for `min`, `max` that supports range queries
## Sparse Table (Class Templates)

{{% details title="Click" closed="true" %}}
```c++
template<typename T, T (*F)(T, T)>
class SparseTable {
    // everything is 1-indexed here!

/** "NOTES"

    length n -> required
    table -> n x log2(n)
    constructor should accept the vector A
    precompute function -> fills in the sparse table. -1 for invalid ranges
    table[i][0] = answer for range[i, i + 2^0) = element[i];
    table[i][1] = answer for range[i, i + 2^1) = ans(i, i + 1) = ans(table[i][0], table[i + 1][0]);
    table[i][k] = answer for range[i, i + 2^k) = ans(range[i, i + 2^{k - 1}), range[i + 2^{k - 1}, i + 2^k))
                = ans(table[i][k - 1], table[i + (1LL << (k - 1))])
 */

public:
    i64 n;
    i64 height;

    std::vector<T> a;
    std::vector<std::vector<T>> table;
    
    SparseTable(const std::vector<T>& arr): a(arr), n(arr.size() - 1) {
        precompute();
    }

    SparseTable(const std::vector<T>& arr, i64 size): a(arr), n(size) {
        precompute();
    }

    // build the table
    void precompute() {
        if (n == 0) return;
        
        height = (i64)log2(n) + 1;
        table.resize(n + 1, std::vector<i64>(height + 1, -1));

        // build the sparse tables
        for (ll i = 1; i <= n; i++) {
            table[i][0] = a[i];
        }

        for (ll j = 1; j <= height; j++) {
            for (ll i = 1; i + (1LL << j) <= n + 1; i++) {
                table[i][j] = F(table[i][j - 1], table[i + (1LL << (j - 1))][j - 1]);
            }
        }
    }

    // print the table
    void print_table() {
        std::cout << "Sparse Table:\n";
        for (ll i = 1; i <= n; i++) {
            for (ll j = 0; j <= height; j++) {
                std::cout << table[i][j] << " \n"[j == height];
            }
        }
    }

    // [l, r] -> range query (inclusive bounds)
    i64 range(int l, int r) {
        if (l > r) return -1;
        if (l == r) return a[l];

        int length = (int)log2(r - l + 1);
        return F(table[l][length], table[r - (1LL << length) + 1][length]);
    }
};

inline i64 minll(i64 a, i64 b) { return std::min(a, b); }
inline i64 maxll(i64 a, i64 b) { return std::max(a, b); }
inline i64 gcd(i64 a, i64 b) { return std::gcd(a, b); }

using SparseMin = SparseTable<i64, minll>;
using SparseMax = SparseTable<i64, maxll>;
using SparseGCD = SparseTable<i64, gcd>;
```
{{% /details %}}
