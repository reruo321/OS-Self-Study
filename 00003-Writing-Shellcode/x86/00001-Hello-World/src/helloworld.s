.data
hello:
        .string "Hello, World!\n"
        len = . - hello
.text
.global _start
_start:
        movl $0x04, %eax
        movl $1, %ebx
        movl $hello, %ecx
        movl $len, %edx
        int $0x80

        movl $0x01, %eax
        movl $0, %ebx
        int $0x80
