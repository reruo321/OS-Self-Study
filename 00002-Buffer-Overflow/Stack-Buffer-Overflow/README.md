# Stack Buffer Overflow
My experimental project for stack buffer overflow, ASLR, and NOP sled.

## Summary
1. **Stack Buffer Overflow**: The exploit attack to overwrite things on the stack.
2. **ASLR**: The defense to increase system's entropy pool and security. Reduces exploitation possibility of stack buffer overflow attack.
3. **NOP Sled**: The sequence of NOP instructions to slide the CPU's instruction execution flow. It is usually used to exploit software by reaching the exploit code.

## Prerequisites
### Disabling ASLR
To exploit the program easily for study purpose, we can disable ASLR. It is recommended to disable just temporary for your computer's security.

#### Checking
Check if the `main`'s entry address of the program is continuously changed whenever you run it on GDB.

    (gdb) disas main

If does, ASLR is active.

To check the ASLR setting in Ubuntu, type this on the terminal.
      
    $ cat /proc/sys/kernel/randomize_va_space

* 0: No randomization
* 1: Conservative randomization
* 2: Full randomization

#### Disabling Temporary
When you disable ASLR temporary, it will be enabled again after reboot.

##### Solution 1
The command disables randomization temporarily in Ubuntu.

    echo 0 > /proc/sys/kernel/randomize_va_space

##### Solution 2
The command summons a shell with ASLR disabled. Any commands being run from the shell are ASLR-disabled too.

    setarch `uname -m` -R $SHELL

##### Solution 3
If ASLR still works, disable GDB's ASLR.

    (gdb) set disable-randomization on

To turn it on again,

    (gdb) set disable-randomization off

## Steps
### Compiling
Compile the code as 32-bit with the debugging information.

    gcc -g -o hello hello.c -m32 (-mpreferred-stack-boundary=2)

* [What is `-mpreferred-stack-boundary`?](https://github.com/reruo321/CPP-Self-Study/blob/master/CS/Assembly/GCC/-mpreferred-stack-boundary/README.md)

### Examining Source
We can examine the source of the program compiled with `-g` option, using GDB, in several ways.

#### 1. `info fun`
The command is used to see all defined functions in the program.

    (gdb) info fun

![infofun](https://github.com/reruo321/OS-Self-Study/assets/48712088/00a9bd56-635f-4b13-a59a-6199b63265e1)

We can assume `strcpy()` call might be vulnerable.

#### 2. `list`
The command is used to display the source code.

    (gdb) list

![list](https://github.com/reruo321/OS-Self-Study/assets/48712088/3b5dc9d7-ef78-464f-a0bc-33d0a4fbd03d)

We can find `strcpy()` part is vulnerable.

#### 3. *Objdump*
Unfortunately, we cannot work with two cheats above on normal programs having neither source code nor debugging information. Instead, we should manually examine its assembly code with ***objdump***.

### 
