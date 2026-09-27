
global maxofthree
section .text

maxofthree:
    mov rax, rdi
    cmp rax, rsi
    cmovl rax, rsi
    cmp rax, rdx
    cmovl rax, rdx
    ret
    
