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
5. Make a payload: `NOP sled + Shellcode + Extra bytes`
6. Execute the payload, and inspect the memory of crashed program.
7. Select one of the word-addresses in the NOP sled' part.
8. In the payload, replace the extra bytes with the repetition of word-address you chose from the Step 7.
9. Execute the payload again, and see if it runs a shell.

### Bypassing ASLR
1. Brute Force Attack
2. NOP Sled
3. Restrict Entropy
4. Information Leak

### Notes
1. When examining the program, the exact addresses, immediates, or instructions from my project may be different in yours! Despite the same environment with the same computer, they can be changed every single time you start the GDB.

2. The practice assumes there is no ASLR in an exploited environment. If ASLR is enabled, the probability to succeed an exploitation becomes `Bytes-of-NOP-Sled / Range-of-Address-Randomization`. It is the the most efficient exploitation formula when considering just two factors.

![divvssub](https://github.com/reruo321/OS-Self-Study/assets/48712088/530e82d0-4ade-437f-afa7-ef1c0ebfd7e7)

When we exploit by overwriting a return address, other exploiting patterns - such as considering all cases of placing the starting sled in the offset `0 ~ (Range-of-Address-Randomization - Bytes-of-NOP-Sled)` in byte-address, like the right side of the figure, is also okay. However, because of the data alignment, the return address will be always word-address aligned. (It will lie one of the rows in the figure.) Therefore, it only increases the denominator, decreases the probability, so becomes less efficient way to exploit.

3. According to the *Notes 2*, it is good to increase the bytes of NOP sled to succeed in the exploit as many as we can. The more NOPs you have, the more chance for you to land in the sled. However, the upper limit of them is `BUFFER_BYTES - SHELLCODE_BYTES`, meaning it will be hard to exploit a tiny buffer.
  
   In this case, you can exploit with the **environment variables**! Find the return addresses of the variables, overwrite one of them, and exploit. (I will explain it in detail later...)

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

    $ echo 0 > /proc/sys/kernel/randomize_va_space

(If the permission denied, try below.)

    $ sudo bash -c "echo 0 > /proc/sys/kernel/randomize_va_space"

To enable it again without rebooting, try the same command with the number `0` changed to `2`.

##### Solution 2
The command summons a shell with ASLR disabled. Any commands being run from the shell are ASLR-disabled too.

    $ setarch `uname -m` -R $SHELL

##### Solution 3
If ASLR still works, disable GDB's ASLR.

    (gdb) set disable-randomization on

To turn it on again,

    (gdb) set disable-randomization off

### 2. Compiling
Compile the code as 32-bit with the debugging information.

    $ gcc -g hello.c -o hello -fno-stack-protector -m32

* [What is `-mpreferred-stack-boundary`?](https://github.com/reruo321/CPP-Self-Study/blob/master/CS/Assembly/GCC/-mpreferred-stack-boundary/README.md)

### 3. Examining Source
By examining the source, we can find the vulnerability of the program. We can do it in several ways.

#### 1. `info fun`
The command is used to see all defined functions in the program.

    (gdb) info fun

![infofun](https://github.com/reruo321/OS-Self-Study/assets/48712088/00a9bd56-635f-4b13-a59a-6199b63265e1)

We can assume `strcpy` call might be vulnerable.

#### 2. `list`
The command is used to display the source code.

    (gdb) list

![list](https://github.com/reruo321/OS-Self-Study/assets/48712088/3b5dc9d7-ef78-464f-a0bc-33d0a4fbd03d)

We can find `strcpy` part in `fun` is vulnerable.

#### 3. *Objdump*
We could examine the source code with the two methods above. Unfortunately, we cannot work with them on normal programs having neither original source code nor debugging information. Instead, we should manually examine its assembly code with ***objdump***.

### 4. Analyzing Stack
![retaddress](https://github.com/reruo321/OS-Self-Study/assets/48712088/32eec58c-79bf-417a-861d-b085536c7249)

Disassembling `main`, we learn that the return address after `fun` is `0x56556202`.

![print ret](https://github.com/reruo321/OS-Self-Study/assets/48712088/b08f90ee-0049-49a1-8c6f-678e9d4c1809)

Also, by tracking `%esp` by `i r` command, we can find the stack grows down from `0xffffd084` to `0xffffd080` when calling `fun`. This means that the return address is stored in `0xffffd080`.

![x100retadd](https://github.com/reruo321/OS-Self-Study/assets/48712088/56e6710b-a909-40a1-b06b-adce4367af6a)

    (gdb) x/100wx $sp-200

(We can also scan the stack by using `x` (examine) command around `%esp`.

![funallocate7c](https://github.com/reruo321/OS-Self-Study/assets/48712088/f7e2202f-06ad-4ae3-ac28-00437355133b)

(No further stack frame change after `0x565561e1 nop`, before `leave` which releases the stack frame.)

Here are the instructions that changes the stack frame of `fun`, before `call` on `strcpy`. (It will fill the buffer with user's input.)

    0x565561ad <+0>:	push   %ebp
    0x565561b0 <+3>:	push   %ebx
    0x565561b1 <+4>:	sub    $0x7c,%esp
    0x565561bf <+18>:	push   0x8(%ebp)
    0x565561c5 <+24>:	push   %eax

Since they totally subtract `0x8c` from `%esp`, it becomes `0xffffcff4`.

![stackbefore](https://github.com/reruo321/OS-Self-Study/assets/48712088/1c257fde-5052-433f-b3d5-2ab55344d452)

The figure above shows a part of the stack segment in the memory. The red box is the return address which is the part of stack frame for `main`. The blue highlighted part out of the red box is the stack frame for `fun`.

![stackdraw](https://github.com/reruo321/OS-Self-Study/assets/48712088/13c7d35f-07b3-46d7-8a70-6dbf9322fb79)

We can represent the memory like the figure above.

Let's overwrite the return address to see if the analysis was correct! Run the program with this command:

    (gdb) run $(python -c 'print("\x41" * 127 + "\x42" * 4 + "\x43" + "\x44" + "\x45" + "\x46")')

![stackafter](https://github.com/reruo321/OS-Self-Study/assets/48712088/ff036a6f-0134-4c17-8243-16daa7942cbc)

![stackoverdraw](https://github.com/reruo321/OS-Self-Study/assets/48712088/885d82a9-13ef-4a17-83bc-638c9bd9dfe2)

After `strcpy`, the memory becomes like two figures above. The return address is overwritten with some bytes of the input, `0x46454443`.

![sisegment](https://github.com/reruo321/OS-Self-Study/assets/48712088/3e995ecd-6800-4782-9f71-d7705721a37f)

After `ret`, `%eip` goes to `0x46454443`. Since there is nothing in the address, the program receives "Segmentation fault".

### 5. Making Payload
**Payload** of a malicious program is a description to tell the program what to do on a victim's computer. The payload we will use consists of `NOP sled + Shellcode + Extra bytes`.

#### A. NOP Sled


#### B. Shellcode

#### C. Extra Bytes


run $(python -c 'print("\x41" * 127 + "\x42" * 4 + "\x43" + "\x44" + "\x45" + "\x46")')
