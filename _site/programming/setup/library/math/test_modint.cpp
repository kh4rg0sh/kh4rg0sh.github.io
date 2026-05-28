#include "modint.hpp"
#include <cassert>
#include <random>
using namespace std;

mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());

i64 rand_ll(i64 l, i64 r) {
    return uniform_int_distribution<i64>(l, r)(rng);
}

// brute mod normalize
i64 norm(i64 x, i64 mod) {
    x %= mod;
    if (x < 0) x += mod;
    return x;
}

void basic_tests() {
    z1 a = 5, b = 3;

    assert((a + b).x == 8);
    assert((a - b).x == 2);
    assert((a * b).x == 15);
    assert((a / b).x == (5LL * z1(3).inv().x) % MOD1);

    assert((-a).x == norm(-5, MOD1));

    z1 c;
    c = 10;
    assert(c.x == 10);

    cout << "Basic tests passed\n";
}

void edge_tests() {
    z1 a = 0;
    z1 b = MOD1 - 1;

    assert((a + b).x == MOD1 - 1);
    assert((b + 1).x == 0);
    assert((a - 1).x == MOD1 - 1);
    assert((b * 2).x == (2 * (MOD1 - 1)) % MOD1);

    z1 big = (i64)1e18;
    assert(big.x == norm(1e18, MOD1));

    z1 neg = -1;
    assert(neg.x == MOD1 - 1);

    cout << "Edge tests passed\n";
}

void algebra_tests() {
    for (int i = 0; i < 100000; i++) {
        i64 x = rand_ll(-1e18, 1e18);
        i64 y = rand_ll(-1e18, 1e18);
        i64 z = rand_ll(-1e18, 1e18);

        z1 a = x, b = y, c = z;

        // associativity
        assert(((a + b) + c).x == (a + (b + c)).x);
        assert(((a * b) * c).x == (a * (b * c)).x);

        // distributive
        assert((a * (b + c)).x == (a * b + a * c).x);

        // identity
        assert((a + z1(0)).x == a.x);
        assert((a * z1(1)).x == a.x);

        // inverse (only if non-zero)
        if (b.x != 0) {
            assert((b * b.inv()).x == 1);
        }
    }

    cout << "Algebra tests passed\n";
}

void random_stress() {
    for (int i = 0; i < 200000; i++) {
        i64 x = rand_ll(-1e18, 1e18);
        i64 y = rand_ll(-1e18, 1e18);

        z1 a = x, b = y;

        // compare with brute mod
        assert((a + b).x == norm(x + y, MOD1));
        assert((a - b).x == norm(x - y, MOD1));
        assert((a * b).x == norm((__int128)x * y % MOD1, MOD1));

        if (b.x != 0) {
            i64 inv_b = z1(b).inv().x;
            assert((a / b).x == (a.x * inv_b) % MOD1);
        }
    }

    cout << "Random stress passed\n";
}

void cross_mod_test() {
    for (int i = 0; i < 100000; i++) {
        i64 x = rand_ll(-1e18, 1e18);

        z1 a = x;
        z2 b = x;

        assert(a.x == norm(x, MOD1));
        assert(b.x == norm(x, MOD2));
    }

    cout << "Cross-mod test passed\n";
}

int main() {
    basic_tests();
    edge_tests();
    algebra_tests();
    random_stress();
    cross_mod_test();

    cout << "All tests passed\n";
}