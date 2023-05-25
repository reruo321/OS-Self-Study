# GDB
## (No debugging symbols found in `PROGRAM`)
There is no debugging information GDB can work with in the `PROGRAM`.
### Solution
#### 1. Use `-g` option when you compile the program with GCC.
`-g` option in GCC produces debugging information in the operating system’s native format, and GDB can work with it.

    $ gcc -g hello.c -o hello
