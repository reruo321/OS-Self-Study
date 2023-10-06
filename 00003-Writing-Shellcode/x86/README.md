# Shellcode on x86
## 32-bit Executable in Linux x86_64
### GAS (AT&T Syntax)
Normally, compiling the assembly code in Linux x86_64 like this:

    $ gcc -c hello.s && ld hello.o -o hello

Will get a 64-bit executable.

    $ file hello
> hello: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped

If you want to compile 32-bit one, add some options like this:

    $ gcc -c hello.s -m32 && ld hello.o -o hello -melf_i386

You can confirm the result is 32-bit.

    $ file hello
> hello: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, not stripped

### NASM (Intel Syntax)
    $ nasm -f elf hello.asm

Works well, but when you link your objective files into an executable file like this:

    $ ld hello.o -o hello

It will make a complaint.

> ld: i386 architecture of input file `hello.o' is incompatible with i386:x86-64 output

You should add `-melf_i386` option to `ld`!

    $ ld hello.o -o hello -melf_i386

After the linking, it successfully creates a 32-bit executable file.

    $ file hello
> hello: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, not stripped

