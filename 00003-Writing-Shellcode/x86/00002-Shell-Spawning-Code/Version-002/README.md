# Shell-Spawning Code (Version. 2)

* (SPOILER) Reference: [0x2a5 Avoiding Using Other Segments](https://bista.sites.dmi.unipg.it/didattica/sicurezza-pg/buffer-overrun/hacking-book/0x2a0-writing_shellcode.html)

## Introduction
In the [Version. 1](https://github.com/reruo321/OS-Self-Study/tree/main/00003-Writing-Shellcode/x86/00002-Shell-Spawning-Code/Version-001), we have created our first shellcode as an executable file. However, it is an unusual form, and we should make it "injected" into another working executable file.

## Checklist
Let's consider changing some parts of the [Version. 1 code](https://github.com/reruo321/OS-Self-Study/blob/main/00003-Writing-Shellcode/x86/00002-Shell-Spawning-Code/Version-001/src/spawn1.s).

1. What problems will be encounted when we change the form of shellcode execution?
