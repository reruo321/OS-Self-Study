.data
hello:
        .string "Hello, 64-bit World!\n"
        len = . - hello

.text
.global _start
_start:
        movl $1, %eax
        movl $1, %edi
        movl $hello, %esi
        movl $len, %edx
        syscall

        movl $60, %eax
        movl $0, %edi
        syscall
