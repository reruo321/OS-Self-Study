# Shell-Spawning Code (Version. 3)

* (SPOILER) Reference: [0x2a6 Removing Null Bytes](https://bista.sites.dmi.unipg.it/didattica/sicurezza-pg/buffer-overrun/hacking-book/0x2a0-writing_shellcode.html)

## Introduction
In the [Version. 2](https://github.com/reruo321/OS-Self-Study/tree/main/00003-Writing-Shellcode/x86/00002-Shell-Spawning-Code/Version-002),
our shellcode had the injecting form.
However, we cannot use it yet because there are some problems.

## TODO
1. Compile the previous [Version. 2 code](https://github.com/reruo321/OS-Self-Study/blob/main/00003-Writing-Shellcode/x86/00002-Shell-Spawning-Code/Version-002/src/spawn2.s).
2. Open the executable file with a hex editor.
3. Can you find which part(s) will make the problem? Remind that we are going to copy the shellcode into the buffer. (See the Hint 1 below if you still don't get it.)
4. 

## Hints
### Hint 1
<details>
  <summary><b>SPOILERS</b></summary>
  
We will inject the shellcode using some vulnerable C functions, such as `strcpy`, `strcat`, and `printf`. There are some `00`s in the code. `00` is the hexadecimal notation for null. Imagine, you are going to put a bunch of bytes including `\0`s into the `strcpy`!
Therefore, only some bytes in front of the first `00` will run.
</details>

## Solution
<details>
  <summary><b>SPOILERS</b></summary>
</details>

### Assembly
    
