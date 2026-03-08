#pragma once
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

