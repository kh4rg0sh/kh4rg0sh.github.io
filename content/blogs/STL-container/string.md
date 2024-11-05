---
linkTitle: std::string
title: std::string
type: docs
math: true
weight: 1
---
# Introduction
let's talk about the STL container `std::string`. i looked up `string` in the source code and i found the `string` header file.

{{% details title="Source Code" closed="true" %}}
the source code can be found here
> https://gcc.gnu.org/onlinedocs/gcc-11.4.0/libstdc++/api/a00200_source.html

```cpp {filename=string.c, linenos=table}
#ifndef _GLIBCXX_STRING
#define _GLIBCXX_STRING 1
 
#pragma GCC system_header
 
#include <bits/c++config.h>
#include <bits/stringfwd.h>
#include <bits/char_traits.h>  // NB: In turn includes stl_algobase.h
#include <bits/allocator.h>
#include <bits/cpp_type_traits.h>
#include <bits/localefwd.h>    // For operators >>, <<, and getline.
#include <bits/ostream_insert.h>
#include <bits/stl_iterator_base_types.h>
#include <bits/stl_iterator_base_funcs.h>
#include <bits/stl_iterator.h>
#include <bits/stl_function.h> // For less
#include <ext/numeric_traits.h>
#include <bits/stl_algobase.h>
#if __cplusplus > 201703L
#  include <bits/stl_algo.h> // For remove and remove_if
#endif // C++20
#include <bits/range_access.h>
#include <bits/basic_string.h>
#include <bits/basic_string.tcc>
 
#if __cplusplus >= 201703L && _GLIBCXX_USE_CXX11_ABI
namespace std _GLIBCXX_VISIBILITY(default)
{
_GLIBCXX_BEGIN_NAMESPACE_VERSION
  namespace pmr {
    template<typename _Tp> class polymorphic_allocator;
    template<typename _CharT, typename _Traits = char_traits<_CharT>>
      using basic_string = std::basic_string<_CharT, _Traits,
                                             polymorphic_allocator<_CharT>>;
    using string    = basic_string<char>;
#ifdef _GLIBCXX_USE_CHAR8_T
    using u8string  = basic_string<char8_t>;
#endif
    using u16string = basic_string<char16_t>;
    using u32string = basic_string<char32_t>;
#ifdef _GLIBCXX_USE_WCHAR_T
    using wstring   = basic_string<wchar_t>;
#endif
  } // namespace pmr
 
  template<typename _Str>
    struct __hash_string_base
    : public __hash_base<size_t, _Str>
    {
      size_t
      operator()(const _Str& __s) const noexcept
      { return hash<basic_string_view<typename _Str::value_type>>{}(__s); }
    };
 
  template<>
    struct hash<pmr::string>
    : public __hash_string_base<pmr::string>
    { };
#ifdef _GLIBCXX_USE_CHAR8_T
  template<>
    struct hash<pmr::u8string>
    : public __hash_string_base<pmr::u8string>
    { };
#endif
  template<>
    struct hash<pmr::u16string>
    : public __hash_string_base<pmr::u16string>
    { };
  template<>
    struct hash<pmr::u32string>
    : public __hash_string_base<pmr::u32string>
    { };
#ifdef _GLIBCXX_USE_WCHAR_T
  template<>
    struct hash<pmr::wstring>
    : public __hash_string_base<pmr::wstring>
    { };
#endif
 
_GLIBCXX_END_NAMESPACE_VERSION
} // namespace std
#endif // C++17
 
#if __cplusplus > 201703L
namespace std _GLIBCXX_VISIBILITY(default)
{
_GLIBCXX_BEGIN_NAMESPACE_VERSION
 
#define __cpp_lib_erase_if 202002L
 
  template<typename _CharT, typename _Traits, typename _Alloc,
           typename _Predicate>
    inline typename basic_string<_CharT, _Traits, _Alloc>::size_type
    erase_if(basic_string<_CharT, _Traits, _Alloc>& __cont, _Predicate __pred)
    {
      const auto __osz = __cont.size();
      __cont.erase(std::remove_if(__cont.begin(), __cont.end(), __pred),
                   __cont.end());
      return __osz - __cont.size();
    }
 
  template<typename _CharT, typename _Traits, typename _Alloc, typename _Up>
    inline typename basic_string<_CharT, _Traits, _Alloc>::size_type
    erase(basic_string<_CharT, _Traits, _Alloc>& __cont, const _Up& __value)
    {
      const auto __osz = __cont.size();
      __cont.erase(std::remove(__cont.begin(), __cont.end(), __value),
                   __cont.end());
      return __osz - __cont.size();
    }
_GLIBCXX_END_NAMESPACE_VERSION
} // namespace std
#endif // C++20
 
#endif /* _GLIBCXX_STRING */
```
{{% /details %}}

we observe that `string` internally calls multiple other header files where the actual `std::string` implementation is handled. the source file defines a couple of template classes that manage all the other interal inheritance to provide an interface for clean use. for example, take a look at some of the common ways to construct a string.
```c++ {linenos=table}
std::string a;
std::string b(5, 'a');
```
in the above source code, if we take a careful look at the following lines
```cpp {filename=string.c, linenos=table, linenostart=31}
    template<typename _Tp> class polymorphic_allocator;
    template<typename _CharT, typename _Traits = char_traits<_CharT>>
        using basic_string = std::basic_string<_CharT, _Traits,
                                             polymorphic_allocator<_CharT>>;
    using string    = basic_string<char>;
```
this tells us that `string` is an alias template for `basic_string<char>` which itself is an alias template for `std::basic_string<_CharT, _Traits, polymorphic_allocate<_CharT>>;`

## Reversing std::string
---
to analyse what is the actual file dealing with `std::string` handling, i decided to write this program that defines a string, compile it and reverse the binary.
```cpp {filename=main.c, linenos=table}
#include <string>

int main() {
    std::string a;
}
```
let's decompile this in IDA and the `main` function decompiles to
```c {filename=main.c, linenos=table}
int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4[40]; // [rsp+0h] [rbp-30h] BYREF
  unsigned __int64 v5; // [rsp+28h] [rbp-8h]

  v5 = __readfsqword(0x28u);
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::basic_string();
  std::__cxx11::basic_string<char,std::char_traits<char>,std::allocator<char>>::~basic_string(v4);
  return 0;
}
```
the decompilation proves the previously conjectured observations. since, `std::string` actually falls back to the implementation of the instantiated template class `std::basic_string<_CharT, _Traits, _Alloc>::basic_string` therefore, before exiting the procedure it calls the destructor of the class. 

### References
---
{{< callout type="info">}} 
1. https://gcc.gnu.org/onlinedocs/gcc-11.4.0/libstdc++/api/a04638.html#add45a9cfe4bd5a6d6881c4cbe5d54e4a 
2. https://gcc.gnu.org/onlinedocs/gcc-11.4.0/libstdc++/api/a00200_source.html

{{< /callout>}}

## Memory of the Container 
---
when an object of `std::string` class is instantiated, it is created on the stack. i wrote a simple program and inspected the memory using gdb. here's a TLDR of what i found. 
```md
+00: <pointer to data region>
+08: <data region size>
+10: <data area capacity> OR <data region>
+18: <not used> OR <data region + 08h>
```
1. to get a pointer to the object `std::string a;`, use `&a;`
2. to get the size of the data region of the object, `std::string a; std::cout << a.size();`
3. if the data in the `std::string` is less than `16 bytes` then the next two quad words are repurposed as the data region, otherwise the data region is a malloced chunk on the heap. the data region is the size of the data in the string and not the size of the region. 
4. `.c_str()` returns a pointer to the data region of the object. and so does `.data()` function.

```cpp {filename=test.cpp, linenos=table}
#include <string>
#include <iostream>
#include <stdio.h>

int main() {
    std::string a = "helloo";
    printf("%s\n%p\n%p\n", a.c_str(), &a, a.c_str());
}
```
{{% details title="output of the program" closed="true" %}}
```bash
helloo
0x7fff8c829570
0x7fff8c829580
```
{{% /details %}}

