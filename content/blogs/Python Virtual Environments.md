---
title: How I fixed the python mess on my system
math: true
type: docs
weight: 3
sidebar: 
    open: true
---

In this post, I'll be talking about how I figured out and fixed the python configuration mess that I had unknowingly created on my system. 

## Some Context
I was a traditional Windows + Ubuntu WSL user for years, until I decided it was the need of time to switch to Linux. On the New Year's Eve of 2024, I was installing Ubuntu 24.04 on my laptop and creating a nice aesthetic setup for myself. I hadn't previously used a pure Linux system before (if you exclude VMs and WSL). Well, getting to the point of the post:

If you didn't know this already, Ubuntu 24.04 is packaged with Python by default. But that's all I knew about it. And I definitely had no clue about the standard way of using Python on Ubuntu 24.04. I'm a simple guy. I do `python3 --version` and if it spits out something nice, I assume yay it's all working fine and that's all I would care about. Or maybe spin up the Python Interpreter in the terminal and try `2 + 2` or something. That's how I knew Python is okay on my system.

Those days, I would quite frequently have to use `SageMath` for scripting. For those who don't know about `SageMath`, it's a Python library that is used to perform advanced mathematics computation and scripting. It's quite convenient if you use Python for CTF Cryptography. So that was definitely the first thing I installed on my system, related to Python. Took me about 2 or 3 hours I think and after that I installed VS Code, Jupyter Notebook and tried out my usual setup. It worked! the code snippets were working fine and that is what mattered to me!

Later that day, I think I installed `Oh My Zsh` on my system. And over the course of the next few days, I installed a lot of softwares I would frequently use on my system. And as months passed by, and I kept working on different projects, my `~/.bashrc` and `~/.zshrc` files were full of unmaintained garbage configurations.

## So what's the problem?
"So you are basically saying that you could work on projects for months on your system without any issue. What's the problem then?"

Yes. If it works fine, doesn't deny the existence of crippling garbage behind the scenes that could snap at any moment and introduce bugs you don't know why tf they even exist. I had just avoided the pile of garbage for too long already until I decided to address the issue and look out for a fix and get it fixed goddamnit.

## The first problem - "pip3 install"
Over the past years, whenever I needed to use a python package that wasn't available on my system. I would just do `pip3 install <name-of-the-package>` and get it installed on my system. I really loved looking at the pip package installation on my terminal with those flashy colourful loading bars, making me feel as if I'm doing something cool.

Well, if i go ahead and do `pip3 install pycryptodome` on my current system: this is what it does

```bash
 [~/work_dir/7th_sem/cp]
kh4rg0sh  pip3 install pycryptodome

[notice] A new release of pip is available: 24.2 -> 25.2
[notice] To update, run: pip install --upgrade pip
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.
    
    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.
    
    If you wish to install a non-Debian packaged Python application,
    it may be easiest to use pipx install xyz, which will manage a
    virtual environment for you. Make sure you have pipx installed.
    
    See /usr/share/doc/python3.12/README.venv for more information.

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
               
 [~/work_dir/7th_sem/cp]
 kh4rg0sh  
```

What the Fuck?

Why wouldn't it work. It used to work right? Why is it complaining about something. Oh well, it gives me a fix. Oh, let me read the fix what does it say. 

"pass the flag `--break-system-packages`"

Goddamnit, I am not running that without understanding what it does. On top of that, why break system packages that just sounds so fishy. 

I had no clue about what is happening, until I decided to look into "what is happening".

### PEP 668 (The Cause!)
PEP 668 is python enhancement proposal to manage conflicts between the packages installed via OS package manners and python package manager. It says that you are not allowed to install python packages directly into externally managed environments. Instead the recommended way of installing packages for global externally managed environments is through the system's package manager (like `apt` on Ubuntu). Unfortunately, Ubuntu 24.04 adopts PEP 668. The python installation is managed by `apt` and therefore, you cannot use `pip` to modify the global site packages through `pip` which it simply refuses to do.

### What do I do then?
The recommended solution is to use Python virtual environments that help us isolate the project dependencies from the system dependencies. But what even are virtual environments? So I decided to dive deeper into how do Python Virtual Environments work.

## Python Virtual Environments

