#pragma once
#include "bits/stdc++.h"

using namespace std;
using i64 = long long;
const i64 MOD1 = 1e9 + 7;
const i64 MOD2 = 998244353;

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
