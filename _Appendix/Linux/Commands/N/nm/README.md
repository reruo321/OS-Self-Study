# `nm`
`nm` stands for **name mangling**,
and the Linux command is used to dump the symbol table and their attributes from a binary executable file.

## Manual
* [Linux man page - `nm`](https://linux.die.net/man/1/nm)

## Example
You can use it on object files for debugging purpose.

I attached a wrong C source code example as "hello_extern.c". If you try to compile it,

    $ gcc -c hello_extern.c

It works successfully. However, when you link it,

    $ ld hello_extern.o -o hello_extern

You will meet linker error messages...

    ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
    ld: hello_extern.o: in function `main':
    hello_extern.c:(.text+0xa): undefined reference to `NN'
    ld: hello_extern.c:(.text+0x20): undefined reference to `printf'

If you use `nm` on "hello_extern.o",

    $ nm hello_extern.o

Information is shown like this:

                     U NN
    0000000000000000 T main
                     U printf

Symbol `U` means "undefined", and `T` means "globally defined in the text section".
We learn that the file "hello_extern.o" declares three symbols but defines only one, `main`. It means that the file DOES also declare `NN` and `printf` but NOT define them. Therefore, the linker is expected to find the definitions of `NN` and `printf` outside.

The linker `ld` finds `printf` when linking with the C Standard Library, but cannot find `NN` anyware. That's why `ld` says "undefined reference to `NN`" error!

## External Links
* [nm](https://linux.die.net/man/1/nm) - `nm` from Linux man page
* [What is extern in C?](https://jameshfisher.com/2017/08/27/c-extern/) - Reference for the example
