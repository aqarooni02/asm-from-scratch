global print_int_signed

section .bss
    buffer resb 23  ; added one more byte for the negative sign
                    ; max int + the '-'

section .text

print_int_signed:
    xor r8b, r8b        ; set r8b to 0 first before any jumps
    mov rax, rdi    ; store param in accumulator register
    lea rsi, [rel buffer + 23]  ; start pointer at end of buffer
    dec rsi
    mov [rsi], 10
    test rax, rax   ; check if 0 case
    js .negative    ; check if negative
    jnz .convertdigit   ; if its not 0 print normally, else fall through and go to done
    dec rsi             ;
    mov byte [rsi], '0' ; these three are case of printing just 0
    jmp .done           ;
    .negative:
        mov r8b, 1      ; r8b is lower 8 bits of r8 given val of 1 indicating negative
    .convertdigit:
        mov rcx, 10     ; we store 10 to rcx as we will div rax by it 
        cqo             ; copy RAX's sign bit through RDX, forming the signed dividend RDX:RAX
        ; div rcx ; rax now has quotient, rdx has remainder..
        ; for signed need to use other div
        ; use idiv command
        idiv rcx
        ; if input was negative all remainders would be negative
        ; so we can just negate dl so instead of -5 its 5 for example
        test dl, dl
        jns .positive_remainder ; jns means jump if sign flag is 0 means its positive
        neg dl  ; negate dl
        .positive_remainder:
            add dl, '0' ; we use the lower 8 bits of rdx and add '0' to it
        dec rsi ; move rsi downwards one byte
        mov [rsi], dl ; add the ascii byte to the end
        test rax, rax
        jnz .convertdigit
    test r8b, r8b   ; if the negative boolean is true add the '-'
    jz .done       ; if r8b is 0 then skip without adding '-' else continue
    dec rsi
    mov [rsi], '-'
    .done:
        ; write(1, msg, len)
        mov rax, 1          ; sys_write
        mov rdi, 1          ; stdout
        ; rsi is already the start of the digit
        ; rsi = buffer + 21 - (num of digits)
        lea rdx, [rel buffer + 23]  ; here we start rdx as the end of the buffer
        sub rdx, rsi                ; then we subtract rsi from rdx to get the length
        syscall

        ret ; dont do exit(0) do ret to return
