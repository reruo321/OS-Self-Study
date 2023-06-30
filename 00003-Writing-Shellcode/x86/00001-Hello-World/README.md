# "Hello, World!" Shellcode
TODO: Write a shellcode that prints out "Hello, World!\n" to the screen.

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

    * ssize_t write(int fd, const void buf[.count], size_t count);
    * void exit(int status);



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

    # exit(int status);
    
        # %eax: Linux system call number (exit = 0x01)
        movl $1, %eax
        # %ebx: arg0, exit status (= 0)
        movl $0, %ebx
        # Linux system call (= interrupt 0x80)
        int $0x80

</details>
