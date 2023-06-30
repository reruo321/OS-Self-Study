# "Hello, World!" Shellcode
![helloworld](https://github.com/reruo321/OS-Self-Study/assets/48712088/b806ccbe-5ea0-46bf-947a-afde68e742e0)

TODO: Write a shellcode that prints out "Hello, World!\n" to the screen in **x86**. Compile and execute the program.

## Hints
<details>
  <summary><b>SPOILERS</b></summary>
  
### Hint 1: Section
1. `.data`: The data section

    a. String "Hello, World!\n"

    b. Length of the string
   
2. `.text`: The code section

    a. `.global`: `_start` (The entry point of the program)
  
    b. `_start`

    * ssize_t write(int *fd*, const void *buf[.count]*, size_t *count*);
    * void _exit(int *status*);

### Hint 2: Compile & Execute

3. Compile & Execute

   a. `gcc`: GNU Compiler

   b. `ld`: GNU Linker

   c. Execute the output

</details>

## Solution

<details>
  <summary><b>SPOILERS</b></summary>

    .data 
    hello:
            .string "Hello, World!\n"
            
    # .: the current address in the data segment
    # . - hello: (the current address) - (the starting address of hello)
            len = . - hello
            
    .text
    .global _start
    _start:
    
    # write(int fd, const void buf[.count], size_t count);
        
        # %eax: Linux system call number (write = 0x04)
        movl $4, %eax
        
        # %ebx: arg0, file descriptor (The standard output device = 1)
        movl $1, %ebx
        
        # %ecx: arg1, pointer to a buffer starting (= hello)
        movl $hello, %ecx
        
        # %edx: arg2, bytes from the buffer starting (= len)
        movl $len, %edx
        
        # Linux system call (= interrupt 0x80)
        int $0x80

    # _exit(int status);
    
        # %eax: Linux system call number (_exit = 0x01)
        movl $1, %eax
        
        # %ebx: arg0, exit status (= 0)
        movl $0, %ebx
        
        # Linux system call (= interrupt 0x80)
        int $0x80

After writing `hello.s`, compile the code with one of these commands.

(In i386)

    $ gcc -c helloworld.s && ld helloworld.o -o helloworld

(In x86-64)

    $ gcc -c helloworld.s -m32 && ld helloworld.o -o helloworld -melf_i386

Execute the program like this.

    $ ./helloworld

</details>
