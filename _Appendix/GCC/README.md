# GCC
## '`-mpreferred-stack-boundary=num`' is not between `X` and 12
`-mpreferred-stack-boundary=num` attempts to keep the stack boundary aligned to a 2 raised to `num` (2^`num`) byte boundary. Note that the default argument is `4`, in other words, 16 bytes.

### Solution
The error occurs when GCC refuses to stack alignment setting to 2^`num` bytes. 
#### 1. Change the argument number
The simplest solution will be. Adjust the number to what the error says.
#### 2. (`num`=2) Generate code for a 32-bit environment.
If `num`=2, the option to make the stack boundary aligned to 2^2 = `4` would not be allowed in 64-bit machines since the width of the address field was increased from `4` bytes to `8` bytes. If you do not want to change the 64-bit environment, use additional GCC options. For example, I used `-m32` option to generate 32-bit environment code. (`-m` options: supported on the SPARC)

    $ gcc -g -o hello hello.c -m32 -mpreferred-stack-boundary=2

#### 3. (`num`=3) Use GCC `-mno-sse` option.
