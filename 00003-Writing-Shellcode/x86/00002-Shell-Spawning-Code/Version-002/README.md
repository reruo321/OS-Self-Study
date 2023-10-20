# Shell-Spawning Code (Version. 2)

* (SPOILER) Reference: [0x2a5 Avoiding Using Other Segments](https://bista.sites.dmi.unipg.it/didattica/sicurezza-pg/buffer-overrun/hacking-book/0x2a0-writing_shellcode.html)

## Introduction
In the [Version. 1](https://github.com/reruo321/OS-Self-Study/tree/main/00003-Writing-Shellcode/x86/00002-Shell-Spawning-Code/Version-001), we have created our first shellcode as an executable file. However, it is an unusual form, and we should make it "injected" into another working executable C program.

## Checklist
Let's write a new shellcode that can be injected, by changing some parts of the [Version. 1 code](https://github.com/reruo321/OS-Self-Study/blob/main/00003-Writing-Shellcode/x86/00002-Shell-Spawning-Code/Version-001/src/spawn1.s).

1. How can we inject the code to a C program and run it? (Hint: How will we read bytes of the code?)
2. Is there any part of code that we cannot use for injecting? If it exists, how can we change it to use it again?
3. After the Checklist 1, can we still find all addresses we should know? If not, what kinds of addresses are unknown? Think about the solutions for each problem. (Hint: stack, return address, GOTO)

## TODO
1. Considering the Checklist above, write the shellcode. You can either edit the code of the previous version, or write a new one.

## Solution
<details>
  <summary><b>SPOILERS</b></summary>
</details>

### Assembly
    
