# `nm`
`nm` stands for **name mangling**,
and the Linux command is used to dump the symbol table and their attributes from a binary executable file.

## Example
You can use it on object files for debugging purpose.

I attached an wrong C source code example as "hello_extern.c". If you try to compile it,

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

Symbol `U` means "undefined", and `T` means "in the text section".
We learn that the file "hello_extern.o" defines only one symbol, `main`. Meanwhile, it DOES also declare `NN` and `printf` but NOT define them. Therefore, the linker is expected to find `NN` and `printf`.
The linker `ld` found `printf` when linking with the C Standard Library, but cannot found `NN` anyware. That's why `ld` said "undefined reference to `NN'"!

(For more information on symbols, check [here](https://linux.die.net/man/1/nm).)

## External Links
* [nm](https://linux.die.net/man/1/nm) - `nm` from Linux man page
* [What is extern in C?](https://jameshfisher.com/2017/08/27/c-extern/) - Reference for the `nm` usage
