# GCC
## '`-mpreferred-stack-boundary=num`' is not between `X` and 12
`-mpreferred-stack-boundary=num` attempts to keep the stack boundary aligned to a 2 raised to `num` (2^`num`) byte boundary. GCC limits to pick `num` between `X` and 12, where `X` is either 3 or 4. Note that the default argument is `4`, 16 bytes.

### Solution
The error occurs when GCC refuses to stack alignment setting to 2^`num` bytes. 
#### 1. Change the argument number
The simplest solution will be. Adjust the number to what the error says.
#### 2. (`num`=2) Generate code for a 32-bit environment.
If `num`=2, the option to make the stack boundary aligned to 2^2 = 4 would not be allowed in 64-bit machines since the width of the address field was increased from `4` bytes to `8` bytes. If you do not want to change the 64-bit environment, use additional GCC options. For example, I used `-m32` option to generate 32-bit environment code. (`-m` options: supported on the SPARC)

    $ gcc -g -o hello hello.c -m32 -mpreferred-stack-boundary=2

#### 3. (`num`=3) Use GCC `-mno-sse` option.
https://gcc.gnu.org/legacy-ml/gcc-patches/2012-05/msg01334.html

If 64-bit machines use 8-byte address field, why the default byte boundary is 16 bytes, instead of 8 bytes?
Actually, it is allowed to set `num`=3 on x86-64 when **SSE extensions** are disabled with GCC's `-mno-sse` option.

x86-64 and AMD64 System V ABI require 16-byte stack alignment, since some SSE instructions and 16-byte aligned objects need such alignment.
Using `-mpreferred-stack-boundary=3` option makes trouble when functions compiled with 16-byte stack alignment are called with misaligned stack. Therefore, you must use `-mno-sse` option on GCC to disable the SSE extensions, or you must build all modules, including any libraries, with the option.
