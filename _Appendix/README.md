# Appendix
I wrote the document to notify some settings and errors I experienced in OS development.

## C/C++
### # C: linux/init.h: No such file or directory.
> hello.c:1:10: fatal error: linux/init.h: No such file or directory.

#### Solution
##### 1. Install Headers
(Terminal) To install just the headers in Ubuntu:

    $ sudo apt install linux-headers-$(uname -r)
    
(Terminal) To install the entire Linux kernel source in Ubuntu:

    $ sudo apt install linux-source

## Makefile
### # make: cc: No such file or directory.
> make: cc: No such file or directory.

#### Solution
You may not have GCC in your system, or the symbolic link `/usr/bin/cc` is missing.

Also note that `cc` in Makefile is case-sensitive.
##### 1. Install GCC

(Terminal) To install just GCC:

    $ sudo apt install gcc
  
(Terminal) To install a C compiler and other tools for building SW:

    $ sudo apt install build-essential

#### 2. Check Symbolic Link
(Terminal) We can check the symbolic link `/usr/bin/cc` by:

    $ type cc
    
(Make) If it is missing, do:

    cc = gcc

### # Makefile: Missing Seperator Error
> Makefile:1: *** missing separator. Stop.

(Korean)
> Makefile:1: *** 분리 기호가 빠졌음.  멈춤.

#### Solution
##### 1. Use Tab
After each target rule, **TAB** character must be placed in the beginning of the line.
Change spaces to TAB if you used them!

Some text editors may replace tabs with white spaces, so we should also choose proper editor for Makefile.

### # make: flex: Command not found
> make: flex: Command not found

#### Solution
Just install `flex`.
##### 1. Install `flex`
    $ sudo apt install flex
    
### # make: bison: Command not found
> make: bison: Command not found

#### Solution
Just install `bison`.
##### 1. Install `bison`
    $ sudo apt install bison
    
### # make: No rule to make target 1
> make\[2\]: *** No rule to make target 'arch/x86/entry/syscalls/syscall_32.tbl', needed by 'arch/x86/include/generated/uapi/asm/unistd_32.h'.  Stop.

#### Solution
##### 1. Change `SUBDIRS=` to `M=`
Support for the variable `SUBDIRS` was removed since Linux 5.3.
##### 2. Change `$(PWD)` to `$(shell pwd)`

### # make: No rule to make target 2
> make\[2\]: *** No rule to make target '/home/reruo/바탕화면/hellokernel/hellok.o', needed by '__build'.  Stop.

#### Solution
##### 1.

### # bits/libc-header-start.h: No such file or directory
> /usr/include/stdio.h:27:10: fatal error: bits/libc-header-start.h: No such file or directory

The error occurs when you try to use `-m32` option for GCC.
#### Solution
##### 1. Install multilib things

    $ sudo apt install gcc-multilib g++-multilib

### # '`-mpreferred-stack-boundary=num`' is not between `X` and 12
`-mpreferred-stack-boundary=num` attempts to keep the stack boundary aligned to a 2 raised to `num` (2^`num`) byte boundary. Note that the default argument is `4`, in other words, 16 bytes.

#### Solution
The error occurs when GCC refuses to stack alignment setting to 2^`num` bytes. 
##### 1. Change the Argument Number
The simplest solution will be. Adjust the number to what the error says.
##### 2. (`num`=2) Generate Code for a 32-bit Environment
If `num`=2, the option to make the stack boundary aligned to 2^2 = `4` would not be allowed in 64-bit machines since the width of the address field was increased from `4` bytes to `8` bytes. If you do not want to change the 64-bit environment, use additional GCC options. For example, I used `-m32` option to generate 32-bit environment code. (`-m` options: supported on the SPARC)

    $ gcc -g -o hello hello.c -m32 -mpreferred-stack-boundary=2

##### 3. (`num`=3)
