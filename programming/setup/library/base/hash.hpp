#pragma once
#include <bits/stdc++.h>

/**
 * usage:
 * unordered_set<i64, custom_hash>
 * unordered_map<i64, i64, custom_hash>
 * // problem: https://atcoder.jp/contests/abc448/tasks/abc448_d
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
 * // problem: https://codeforces.com/contest/1980/problem/E
 * 
 * unordered_map<vector<int>, int, vector_hash<int>>
 * // problem: https://atcoder.jp/contests/abc361/tasks/abc361_d
 */

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
