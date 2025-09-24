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

Virtual Environments are isolated environments that help us manage dependencies and prevent version conflicts and helping maintaining a cleaner setup. 

### Creating a Virtual Environment

In python, you can create virtual environments using the python `venv` module. A very common (popular) way to create python virtual environments is to execute `python3 -m venv` through the command line that asks the python interpreter to execute the module as a script.

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  python3 -m venv venv/    
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  ls -la                                                                                     
total 16
drwxrwxr-x  3 kh4rg0sh kh4rg0sh 4096 Sep 22 12:32 .
drwxrwxr-x 12 kh4rg0sh kh4rg0sh 4096 Sep 19 09:21 ..
-rw-rw-r--  1 kh4rg0sh kh4rg0sh    6 Sep 19 15:22 .gitignore
drwxrwxr-x  5 kh4rg0sh kh4rg0sh 4096 Sep 22 12:32 venv
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  
```

For example, the above command created a virtual environment with the name `venv`.

okay cool, now how do i use this?
### Using Virtual Environments
It is a very common practice to create such separate virtual environments for projects. But how does python know that we are in a virtual environment?

The very common procedure here is to "Activate" the virtual environment. On Unix-based operating systems, this is achieved by executing a bash script

```bash
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  source venv/bin/activate
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh 
```

`activate` is a bash script that does a couple of things (mainly setting up environment variables) and prepares the current terminal session for encapsulation inside an isolated virtual environment. 

Here's the magic now. If we type in `which python3` in the terminal, this should tell us the path to the `python3` interpreter. This is usually `/usr/bin/python3` on Linux.

{{% details title="/bin/python3 vs /usr/bin/python3" closed="true" %}}
I would at times thinkg about what is the difference between `/usr/bin/python3` and `/bin/python3` and why do we have these two separate locations.

Turns out there is quite a historical significance to this and how things are structured today. A short answer is, they are both the same. Plausible explanation is just checking out what `/bin/python3` really is. It is just a symlink to `/usr/bin/python3`. Don't believe me? check this out:

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  ls -ld /bin/python3
lrwxrwxrwx 1 root root 10 Aug  7  2024 /bin/python3 -> python3.12
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  which python3.12
/usr/bin/python3.12
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  ls -ld /usr/bin/python3
lrwxrwxrwx 1 root root 10 Aug  7  2024 /usr/bin/python3 -> python3.12
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  
```

{{% /details %}}

But watch what happens when I execute `which python3` in the same terminal session.

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  source venv/bin/activate
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  which python3
/home/kh4rg0sh/work_dir/7th_sem/bug-practice/venv/bin/python3
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh 
```

It changed the python interpreter location. 

### How did my Python Interpreter location change?
The culprit is the `activation` script. But this is nothing dangerous at all, because these changes are just temporary to this current terminal session and if you switch to a new terminal session, everything is fine okay.

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  which python3
/usr/bin/python3
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh 
```

So what exactly happened? 

`python3` is not a command. When you type that into the terminal, it locates these binaries in the locations mentioned in the `PATH` variable. The activation script actually constructs the location to the Python Interpreter of the virtual environment and prepends it to the `PATH` variable

this is very evident when I execute `echo $PATH`
```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  echo $PATH      
/home/kh4rg0sh/work_dir/7th_sem/bug-practice/venv/bin:/home/kh4rg0sh/work_dir/7th_sem/pwn/handout/depot_tools:/home/kh4rg0sh/.nvm/versions/node/v23.5.0/bin:/home/kh4rg0sh/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/usr/local/go/bin:/opt/gradle/gradle-8.14.1/bin
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  
```

the very first location is matched and that is the virtual environment Python Interpeter. And that is not the only thing it changes. If you type in `which pip3`, the expected location should have been `/usr/bin/pip3` but guess what?

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  which pip3      
/home/kh4rg0sh/work_dir/7th_sem/bug-practice/venv/bin/pip3
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh 
```

Yeah, it points to the `pip3` binary inside the virtual environment!

This achieves a complete isolation by changing the paths to the `python3` and `pip3` binaries (which are the most common ways to interact with a python file and manage dependencies), changing them to point inside the virtual environments.

### How do I disable a Virtual Environment
Cool, we've seen how Python achieves a complete isolation but what if I want to switch back to outside the virtual environment?

It's just as simple as executing `deactivate` in the terminal

```bash
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  deactivate
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh 
```

Watch what happens to the locations of the python binaries

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  which python3   
/usr/bin/python3
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  which pip3   
/usr/bin/pip3
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  
```

And yes, the reason is because the `PATH` environment variable has changed, popping off the path to the `/bin` inside the virtual environment off the `PATH` variables.

Not to mention, `deactivate()` is just a shell script function that was set when you activated the virtual environment and when you type that in the current terminal, it just restores back the older terminal configurations.

## Diving Deeper into Python Virtual Environments
Let's take a look into the internals of what happens behind the scene. If I execute the tree command, I'm going to get a huge list, so let's just limit that to `level=2`

```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  tree -L 2 venv
venv
├── bin
│   ├── activate
│   ├── activate.csh
│   ├── activate.fish
│   ├── Activate.ps1
│   ├── pip
│   ├── pip3
│   ├── pip3.12
│   ├── python -> python3
│   ├── python3 -> /usr/bin/python3
│   └── python3.12 -> python3
├── include
│   └── python3.12
├── lib
│   └── python3.12
├── lib64 -> lib
└── pyvenv.cfg

7 directories, 11 files
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  
```

Let's break this down, what each of these components are responsible for

1. `bin/`: contains all the executables and activation scripts
2. `include/`: actually an empty folder, but used by the python interpreter to include `C` header files for packages installed later into the virtual environment.
3. `lib/`: contains the site-packages where you install the external packages.
4. `lib64/`: to provide compatibility with different versions and systems.
5. `pyvenv.cfg`: a configuration file that contains key value pairs to setup the python virtual environment.

If you inspect the folder structure in `/usr`, this folder structure resembles a simplistic view with relevance to python installation. 

Another peculiar thing to notice, the python interpreter binaries are just a symlink.
### Why Virtual Environments are Light-Weighted
This is again system dependent, but the behaviour on Linux and Windows is that, the python interpeter binaries are never copied inside the virtual environment. Instead, it creates a symlink from the python inside the virtual environment to the global python interpreter. this saves memory, overhead of copying files and preserves the python version between the global python and python inside the virtual environment.

For installing different versions of python interpreter inside the virtual environment, we can't do it without having the binaries installed or we just have to use an external python version management system like `pyenv`.

## How does Python Interpreter achieve Isolation
we know that upon running the activation script, it fiddles with the current session environment variables allowing us to achieve an isolation environment, but how exactly does the python interpeter do that?

### Prefix Finding Process
This is a process to determine the base directory of the python installation and it's current locaiton.

The python interpeter will look for the file `pyvenv.cfg`. 
```bash
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  cat venv/pyvenv.cfg 
home = /usr/bin
include-system-site-packages = false
version = 3.12.3
executable = /usr/bin/python3.12
command = /usr/bin/python3 -m venv /home/kh4rg0sh/work_dir/7th_sem/bug-practice/venv
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh 
```

If it is present, it knows that it is inside a virtual environment. this file contains absolute path of the venv, paths of the python parent directory, etc. These values are used to set the variables `sys.base_prefix`, `sys.prefix`.

`sys.base_prefix`: is the path to the base installation directory according to the `home` key in the `pyvenv.cfg` file.
`sys.prefix`: is set to the directory of the virtual environment itself.

1. if both the values are the same: the python interpreter knows that it is being run in a global execution context.
2. otherwise, it is inside a python virtual environment.

here's what these values look like inside an activated virtual environment
```bash
[~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  python3 -c "import sys; print(sys.base_prefix,'\n',sys.prefix)" 
/usr 
/home/kh4rg0sh/work_dir/7th_sem/bug-practice/venv
               
 [~/work_dir/7th_sem/bug-practice]
 kh4rg0sh  
```

### Finding Modules
the above two paths play a very important role in python's package searching mechanism. 

Usually all the libraries that you install are present in a directory called `site-packages` which is located inside `/lib/python3.12/site-packages`. The python interpreter by default searches for the packages inside this directory. 

`sys.path` contains the list of ultimate locations that python uses to search for modules in python. It uses this list to search for modules when an import statement is executed.

### How is `sys.path` Initialized?

When you execute `python3 <file.py>` the `PATH` variable determines the location of the python interpreter used to run this python file. By default, python adds 
1. the directory containing the input script
2. the current working directory

to `sys.path`, that means it by default searches for module there. Python then searches for the modules in

3. directories specified by `PYTHONPATH` which is another environment variables used for adding python packages to search by default
4. Standard library directories
5. the `site-packages` corresponding to the interpreter.

`site-packages` contain the external python packages that are installed by `pip3`. PEP 668 states that you are not allowed to add packages to global site-packages using pip3.

the standard library are the python built-in modules that are accessible globally. If you've noticed carefully, when you create a virtual environment, it doesn't include the python standard built-in modules in the virtual environment but we are still able to use these. This is because the address in `sys.base_prefix` is used to search for standard built-in modules which point to a global installation whereas the path contained in `sys.prefix` is used to determine the external environment dependent python package installations which is the `site-packages` of the virtual environment.

interesting enough, `PYTHONPATH` is also used by vs code intellisense to determine additional directories to search for to determine the path for import modules.

## Back to "So what's the problem?"
the very first problem was when I typed `which python3` in my terminal, it wasn't pointing to `/usr/bin/python3` 💀 
Instead it was a path to the Python Interpreter inside the virtual environment setup in sage. 

I had no clue why was that happening. It could only mean two things: either I'm enabling a virtual environment by default or my `PATH` environment variables are corrupted. 

I checked my `~/.zshrc` file and skimmed through the holy garbage and found out that I'm activating a virtual environment script by default. It get's even crazier though, `which pip3` was pointing to `/usr/bin/pip3` and it wouldn't allow me to install python packages through `pip3` but `python3` was not pointing to the global python interpreter.

I reset the garbage added to `PATH`, `PYTHONPATH` variables and cleared out junk from the `~/.zshrc` file falling back to a standard python setup on Ubuntu.

1. I enabled `sage` modules and `site-packages` through `PYTHONPATH` that allows any python interpreter to additionally look for `sage` specific packages.
2. I cleared out the `PATH` variable to by default force `python3` to point to `/usr/bin/python3` and same for `pip3`.
3. Thanks to the mess I had created, most of the packages that I require are present in the `site-packages` of `sage` and this is enabled by default due to `PYTHONPATH`. Hence, when i'm not working on a project I can still most of the packages I require.
4. Otherwise, to download external packages, either work in a virtual environment or change the path to the python interpreter in VS Code temporarily.

I've found this setup to be working fine and this stops throwing unexpected errors (that I usually encounter while working with `pycryptodome`). I might update this post if I find better alternatives.
