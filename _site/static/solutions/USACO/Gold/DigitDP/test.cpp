#include <bits/stdc++.h>
#include <cstdlib>

#define ll long long 
#define i64 long long
using i128 = __int128;

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

using namespace std;

const i64 MOD1 = 1e9 + 7;
const i64 MOD2 = 998244353;
const i64 LARGE = 1e17;

struct StringHash {
    i64 B;
    static const i64 MOD = (1LL << 61) - 1;

    int n;
    string s;
    vector<i64> pow, hash1;

    StringHash(const string &str) {
        s = str;
        n = s.size();
        pow.resize(n + 1);
        hash1.resize(n + 1);

        static mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());
        static uniform_int_distribution<i64> dist(256, 1000000000);
        static i64 global_base = dist(rng);
        B = global_base;

        pow[0] = 1;
        for (int i = 1; i <= n; ++i)
            pow[i] = modmul(pow[i - 1], B);

        for (int i = 0; i < n; ++i)
            hash1[i + 1] = modadd(modmul(hash1[i], B), s[i]);
    }

    static i64 modmul(i64 a, i64 b) {
        __int128_t t = (__int128_t)a * b;
        t = (t >> 61) + (t & MOD);
        if (t >= MOD) t -= MOD;
        return (i64)t;
    }

    static i64 modadd(i64 a, i64 b) {
        i64 res = a + b;
        if (res >= MOD) res -= MOD;
        return res;
    }

    i64 get_hash(int l, int r) const {
        i64 val = hash1[r + 1] + MOD - modmul(hash1[l], pow[r - l + 1]);
        if (val >= MOD) val -= MOD;
        return val;
    }

    i64 get_suffix_hash(int len) const {
        if (len > n) return -1;
        return get_hash(n - len, n - 1);
    }

    static bool equal_suffix(const StringHash &A, const StringHash &B, int len) {
        if (len > A.n || len > B.n) return false;
        return A.get_suffix_hash(len) == B.get_suffix_hash(len);
    }
};

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

template <i64 Z>
struct modint {
private:
    i64 norm(i64 x_val) {
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
    modint& operator+=(const modint& other) {
        x = norm(x + other.x);
        return *this;
    }
    modint& operator-=(const modint& other) {
        x = norm(x - other.x);
        return *this;
    }
    modint& operator*=(const modint& other) {
        x = (x * other.x) % Z;
        return *this;
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
    friend modint operator-(modint first, const modint& second) {
        first -= second;
        return first;
    }
    friend modint operator*(modint first, const modint& second) {
        first *= second;
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

template <typename T>
struct MatrixExpo {
/**
    everything is 1-indexed
    n -> size of matrix is n x n
    mod -> optional => used to perform operations modulo mod
    expo -> compute the xth power of the matrix
 */

public:
    i64 n;
    i64 mod = -1;
    std::vector<std::vector<T>> matrix;

    MatrixExpo(std::vector<std::vector<T>>& vec, i64 n): 
        n(n), matrix(vec) {}

    MatrixExpo(std::vector<std::vector<T>>& vec, i64 n, i64 mod):
        n(n), matrix(vec), mod(mod) {}

    // normal matrix multiplication (supports both mod and non mod)
    std::vector<std::vector<T>> multiply(const std::vector<std::vector<T>>& a, 
                                        const std::vector<std::vector<T>>& b) {
        std::vector<std::vector<T>> result(n + 1, std::vector<T>(n + 1, 0));
        
        for (i64 i = 1; i <= n; i++) {
            for (i64 j = 1; j <= n; j++) {
                T sum = 0;
                for (i64 k = 1; k <= n; k++) {
                    if (mod == -1) {
                        sum += a[i][k] * b[k][j];
                    } else {
                        sum = (sum + a[i][k] * b[k][j]) % mod;
                    }
                }
                result[i][j] = sum;
            }
        }
        return result;
    }

    // generate the identity matrix
    std::vector<std::vector<T>> identity() {
        std::vector<std::vector<T>> id(n + 1, std::vector<T>(n + 1, 0));
        for (i64 i = 1; i <= n; i++) {
            id[i][i] = 1;
        }
        return id;
    }
    
    // fast matrix exponentiation
    std::vector<std::vector<T>> expo(i64 x) {
        std::vector<std::vector<T>> result = identity();
        std::vector<std::vector<T>> base = matrix;

        while (x) {
            if (x & 1) {
                result = multiply(result, base);
            }
            base = multiply(base, base);
            x >>= 1;
        }
        return result;
    }
};

struct Answer {
    i64 answer;
};

Answer bruteforce(i64 n, i64 m, i64 k, i64 d) {
    i64 fin = 0;
    for (i64 i = n; i <= m; i++) {
        i64 cur = 0;
        i64 temp = i;
        while (temp > 0) {
            if ((temp % 10) == d) cur++;
            temp /= 10;
        }
        if (cur == k) fin++;
    }

    return { fin };
}

Answer checker(i64 m, i64 k, i64 d) {
    i64 dp[20][20][3];
    std::fill(&dp[0][0][0], &dp[0][0][0] + 20*20*3, 0LL);

    int digit = (m / pow10[18]) % 10;
    for (int D = 0; D <= 9; D++) {
        dp[18][(d == D)][(D >= digit) + (D > digit)] += 1;
    }

    for (int i = 18; i > 0; i--) {
        int digit = (m / pow10[i - 1]) % 10;
        for (int j = 0; j <= 19; j++) {
            for (int D = 0; D <= 9; D++) {
                dp[i - 1][j + (d == D)][(D >= digit) + (D > digit)]
                    += dp[i][j][1];
                
                dp[i - 1][j + (d == D)][0]
                    += dp[i][j][0];

                dp[i - 1][j + (d == D)][2]
                    += dp[i][j][2];
            }
        }
    }

    return { dp[0][k][0] + dp[0][k][1] };
}

void solve() {
    i64 n, m, k, d;
    std::cin >> n >> m >> k >> d;

    i64 answer = checker(m, k, d).answer;
    if (n > 0) answer -= checker(n - 1, k, d).answer;

    std::cout <<  answer << '\n';
}     

int main() {
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(0);

    int t = 1;
    // std::cin >> t;
    
    bool print_tc = false;
    int T = -1; // number of tests you want to debug
    int L = -1; // test number you want to debug

    bool check = true;
    if (check) {
        for (i64 i = 1; i <= 20; i++) {
            for (i64 j = i; j <= 20; j++) {
                for (i64 k = 0; k <= 5; k++) {
                    for (i64 d = 1; d <= 9; d++) {
                        Answer upper_bound = checker(j, k, d);
                        Answer lower_bound = checker(std::max(0LL, i - 1), k, d);
         
                        i64 my_answer = upper_bound.answer - lower_bound.answer;
                        i64 actual_answer = bruteforce(i, j, k, d).answer;

                        if (my_answer == actual_answer) continue;
                        std::cout << "Failed on the testcase: \n" 
                                << "m = " << i << ", " << "n = " << j << ", " 
                                << "k = " << k << ", " << "d = " << d << '\n' 
                                << "your answer = " << my_answer << " | " << "actual answer = " << actual_answer << '\n'; 
                    }
                }
            }
        }
        
        return 0;
    }

    for (int test = 1; test <= t; test++) {
        if (print_tc) {
            if (t == T && test == L) {
                // print the test;
            }
            continue;
        }

        solve();
    }
}


