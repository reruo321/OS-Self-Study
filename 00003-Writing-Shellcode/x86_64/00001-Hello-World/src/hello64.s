.data
hello:
        .string "Hello, 64-bit World!\n"
        len = . - hello

.text
.global _start
_start:
        movq $1, %rax
        movq $1, %rdi
        movq $hello, %rsi
        movq $len, %rdx
        syscall

        movq $60, %rax
        movq $0, %rdi
        syscall

