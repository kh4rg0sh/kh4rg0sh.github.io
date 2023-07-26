---
title: Reversing an Indefinitely Inactive Binary File
date: 2023-07-26 00:00:00 +0530
categories: [CTF]
tags: [reverse-engineering]
---
i came across these types of challenges back in april during one of our club lectures. one of our seniors presented this challenge to us. the overview of the challenge is that the program makes a function call to the `sleep()` function with a huge integer passed in as a parameter. so basically your program enters a state of inactivity and doesn't execute the instructions after it. upon static analysis of the binary files in disassembly, we practically get nothing. so how do we do this? our seniors showed us how to do this. basically you have to set a breakpoint at the sleep function and then continue from the next instruction. this way it skips this infinite state of inactiveness. so this was one of the ways you could solve this challenge. i came across this challenge again today (after like 3 months) and a new idea struck me. maybe, it's a known way to solve such challenges, but it was new to me. nevertheless, i'll present it in this blogpost. 
## GDB Test Drive [PicoCTF 2022 Reverse Engineering (3)]
challenge description
```c++
Can you get the flag?
Download this binary.
Here's the test drive instructions:
$ chmod +x gdbme
$ gdb gdbme
(gdb) layout asm
(gdb) break *(main+99)
(gdb) run
(gdb) jump *(main+104)
```

you can download the binary from <a href="/ignore/rev1/gdbme">here</a>.
### Solution
okay so it looks like the intended way to do this is using the GNU Debugger. we'll do this using <a href="https://github.com/radareorg/radare2">radare2</a>. let's open the binary file in the normal mode
![Desktop View](/assets/images/shot1.png){: width="700" height="400" }
as we can see, we have opened up the binary executable file and we are currently at the instruction `0x00001120`. next, we'll switch to the debugger mode.
![Desktop View](/assets/images/shot11.png){: width="700" height="400" }
to jump to the `main()` function, press `:` and type `s main`
![Desktop View](/assets/images/shot12.png){: width="700" height="400" }
note that we haven't yet analysed the binary file. so we can type `aaa` to analyse the instructions. then type `afl` to view the functions list in this binary file.
![Desktop View](/assets/images/shot13.png){: width="700" height="400" }
we can see that there's this `sym.imp.sleep()` which is problematic. let's skim through the instructions in the `main()` again. exactly at instruction `0x00001325`, we can see the following
![Desktop View](/assets/images/shot14.png){: width="700" height="400" }
the instruction at `0x00001325` moves `0x186a0` to the register `edi`. in the comments we can see that this is referred to as the integer `int s` by radare2. in the next instruction, the file calls `sym.imp.sleep()` and the value held in the register `edi` is passed as an argument to the function. you can see this in the comments writted in the instruction `0x0000132a`. this is where i thought, why not set the variable `s=0` instead of that huge value. so we'll quit the program and open the file again using radare2 (this time in writeable mode). to do this type 
```markdown
r2 -w gdbme
```
now, we type `s 0x00001325` to jump at the desired instruction and press `a` at this instruction.
![Desktop View](/assets/images/shot16.png){: width="700" height="400" }
radare2 asks us to type in the assembly instruction and we'll go ahead and type `mov edi, 0x0` and press enter. you can view that the changes have been made at instruction `0x00001325`. 
![Desktop View](/assets/images/shot17.png){: width="700" height="400" }
we can now go ahead and save the file and exit. now execute this binary file again 
![Desktop View](/assets/images/shot18.png){: width="700" height="400" }
and there we have our flag
```
picoCTF{d3bugg3r_dr1v3_72bd8355}
```
