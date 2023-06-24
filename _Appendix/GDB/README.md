# GDB
## (No debugging symbols found in `PROGRAM`)
There is no debugging information GDB can work with in the `PROGRAM`.
### Solution
#### 1. Use `-g` option when you compile the program with GCC.
`-g` option in GCC produces debugging information in the operating system’s native format, and GDB can work with it.

    $ gcc -g hello.c -o hello

## /bin/bash: python: command not found
### Solution 1
Follow this if you have already installed Python3. It creates a symbolic link.

    $ ln -s /usr/bin/python3 /usr/bin/python
    $ python --version
    Python 3.10.6

## Payload Injection
Did you forget how to put an input in a program on GDB?

Read this: https://reverseengineering.stackexchange.com/questions/13928/managing-inputs-for-payload-injection
