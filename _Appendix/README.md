# Appendix
I wrote the document to notify some settings and errors we should to know for OS development.

## Make
### # Make: CC: No such file or directory.
> Make: cc: No such file or directory.

#### Solution
You may not have GCC in your system, or the symbolic link `/usr/bin/cc` is missing.
##### 1. Install GCC

(Terminal) To install only GCC:

    $ sudo apt install gcc
  
(Terminal) To install a C compiler and other tools for building SW:

    $ sudo apt install build-essential

#### 2. Check Symbolic Link
(Terminal) We can check the symbolic link `/usr/bin/cc` by:

    $ type cc
    
(Make) If it is missing, do:

    CC = gcc

### # Makefile: Missing Seperator Error
> Makefile:1: *** missing separator. Stop.

(Korean)
> Makefile:1: *** 분리 기호가 빠졌음.  멈춤.

#### Solution
##### 1. Use Tab
After each target rule, **TAB** character must be placed in the beginning of the line.
Change spaces to TAB if you used them!

Some text editors may replace tabs with white spaces, so we should also choose proper editor for Makefile.
