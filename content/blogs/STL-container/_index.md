---
title: C++ STL Container
sidebar:
  open: true
---
## Introduction
today i decided to take a look at c++ pwn. c++ library functions are implemented and compiled in `libcstd++`. this binary is locatable on your system. on my system this could be found at
`/lib/x86_64-linux-gnu/libcstd++.so.6` which is symbolic link to the actual binary. on my system this is a symbolic link to `libcstdc++.so.6.0.30`

the source code could be easily looked up online. i found this website 
> https://gcc.gnu.org/onlinedocs/gcc-11.4.0/libstdc++/api

choose the correct `gcc` version according to your system. mine is `11.4.0`. 
## Table of Contents
<table>
  <tr>
    <th>Title</th>
    <th>Link</th>
  </tr>
  <tr>
    <th>std::string</th>
    <th><a href="./backdoorctf2023">link</a></th>
  </tr>
  
</table>