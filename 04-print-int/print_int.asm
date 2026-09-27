global print_int

section .bss
    buffer resb 21

section .text

print_int:
    mov rax, rdi
    lea rsi, [rel buffer + 21]
    test rax, rax
    jnz .convertdigit   ; if its not 0 print normally, else fall through and go to done
    dec rsi
    mov byte [rsi], '0'
    jmp .done
    .convertdigit:
        xor rdx, rdx ; clear previous remainder
        mov rcx, 10
        div rcx ; rax now has quotient, rdx has remainder..
        add dl, '0' ; we use the lower 8 bits of rdx and add '0' to it
        dec rsi ; move rsi downwards one byte
        mov [rsi], dl ; add the ascii byte to the end
        test rax, rax
        jnz .convertdigit
    .done:
        ; write(1, msg, len)
        mov rax, 1          ; sys_write
        mov rdi, 1          ; stdout
        ; rsi is already the start of the digit
        ; rsi = buffer + 21 - (num of digits)
        lea rdx, [rel buffer + 21]  ; here we start rdx as the end of the buffer
        sub rdx, rsi                ; then we subtract rsi from rdx to get the length
        syscall

        ret ; dont do exit(0) do ret to return
