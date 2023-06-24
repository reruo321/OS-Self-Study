# Stack Buffer Overflow Project
My experimental project for stack buffer overflow, ASLR, and NOP sled.

## Summary
### Terminology
* **Stack Buffer Overflow**: An exploit attack to overwrite things on the stack.
* **ASLR**: A defense to increase system's entropy pool and security. Reduces exploitation possibility of stack buffer overflow attack.
* **NOP Sled**: A sequence of NOP instructions to slide the CPU's instruction execution flow. It is usually used to exploit software by reaching the exploit code.
* **Brute Force**: A problem-solving technique that finds all the possible solutions, to find a satisfactory solution to a given problem.
* **Brute Force Attack**: A hacking method that uses trial and error.
* **Restrict Entropy**: Reducing the entropy of the randomized address makes the guess easier. One of the methods to do it is setting a huge amount of dummy environment variables so that making the initial stack size smaller.
* **Information Leak**: A way to use vulnerability exposing some part of randomized address, or dump parts of libraries. It is the most effective way of bypassing ASLR.

### Process
1. (To make the exploit practice easy) Disable ASLR.
2. Compile a source code.
3. Examine the source code to find the vulnerability of the program.
4. Analyze stack to estimate the bytes of payload.
5. Make a payload: `NOP sleds + Shellcode + Extra bytes`
6. Execute the payload, and inspect the memory of crashed program.
7. Select one of the word-addresses in the NOP sleds' part.
8. In the payload, replace the extra bytes with the repetition of word-address you chose from the Step 7.
9. Execute the payload again, and see if it runs a shell.

### Bypassing ASLR
1. Brute Force Attack
2. NOP Sled
3. Restrict Entropy
4. Information Leak

### Notes
1. The practice assumes there is no ASLR in an exploited environment. If ASLR is enabled, the probability to succeed an exploitation becomes `Bytes-of-NOP-Sleds / Range-of-Address-Randomization`.

    When we exploit by overwriting a return address, considering all possibility of placing the starting sleds in all byte-address is also okay. However, it is way more inefficient than placing in the start of word-address. Because of the data alignment, the return address will lie only at an aligned block.

![divvssub](https://github.com/reruo321/OS-Self-Study/assets/48712088/530e82d0-4ade-437f-afa7-ef1c0ebfd7e7)

## 1. Prerequisites
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

### 2. Compiling
Compile the code as 32-bit with the debugging information.

    gcc -g -o hello hello.c -m32 (-mpreferred-stack-boundary=2)

* [What is `-mpreferred-stack-boundary`?](https://github.com/reruo321/CPP-Self-Study/blob/master/CS/Assembly/GCC/-mpreferred-stack-boundary/README.md)

### 3. Examining Source
By examining the source, we can find the vulnerability of the program. We can do it in several ways.

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
We could examine the source code with the two methods above. Unfortunately, we cannot work with them on normal programs having neither original source code nor debugging information. Instead, we should manually examine its assembly code with ***objdump***.

### 3. Analyzing Stack
