---
title: Warm-up before the Stripe Coding Challenge
math: true
---

I had no clue how to begin, so I asked ChatGPT to generate a sample problem. Let's begin!

## Problem [Stack-Based Execution Engine]
You are asked to implement a simple stack-based virtual machine.
The machine processes a sequence of instructions, one per line. Each instruction is one of the following:

- PUSH X:
Push integer X onto the stack.

- POP:
Pop the top element from the stack. If the stack is empty, this is an error.

- ADD:
Pop the top two elements a and b, then push b + a.
(Note: a is the most recently pushed element, b is below it.)
Error if fewer than 2 elements on the stack.

- SUB:
Pop the top two elements a and b, then push b - a.
Error if fewer than 2 elements.

- MUL:
Pop the top two elements a and b, then push b * a.
Error if fewer than 2 elements.

- DIV:
Pop the top two elements a and b, then push integer division b // a.
Error if a == 0 or fewer than 2 elements.

- PRINT:
Pop the top element and print it. Error if stack is empty.

The program terminates when the input ends.
If an error occurs at any point, immediately print ERROR and terminate.

## Solution
For all these practice challenges (as well the main challenge), I'm planning to use Python as I've heard Stripe discourages the use of C++ in their selection process (C++ can get notoriously difficult to handle).

so first, we need to accept all the input at once from the stdin stream. we will use `sys.stdin.read()` in python to accomplish offline processing. the next step would be to split the data into instructions. then for each instruction, we will identify what type of instruction using the opcode spec and perform the appropriate operation.

https://gist.github.com/kh4rg0sh/333e7280b812852cdf2425aea530d69f


you know what, I'm just too anxious. I'm just gonna go ahead and attempt the <a href="/secret/stripe/stripe-coding-challenge">test</a>

