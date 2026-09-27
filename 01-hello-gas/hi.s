.intel_syntax noprefix

.section .data
msg:
    .ascii "Hi \n"
len = . - msg

.section .text
.global _start

_start:
    mov rax, 1 # sys_write
    mov rdi, 1 # stdout
    lea rsi, msg[rip]
    mov rdx, len
    syscall

    mov rax, 60 # sys_exit
    xor rdi, rdi # exit status 0
    syscall
