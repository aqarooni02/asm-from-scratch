global atoi

section .text

atoi:
    ; rdi has the char *buff 
    ; assuming only postive digits
    xor rax, rax    ; resetingg rax to 0
                    ; rax will be our total
    xor r9, r9      ; reset r9 to 0 to be out count
    xor r10, r10    ; used to store 10
    mov r10, 10
    .process_char:
        cmp byte [rdi + r9], 0
        je .done
        xor r8, r8
        add r8b, [rdi + r9] ; add the ascii of curr byte
        sub r8b, '0'        ; sub ascii value of 0 from it
        mul r10     ; multiply rax by 10
        add rax, r8    ; add the 8 bits of r8 to it
        inc r9
        jmp .process_char
    .done:
       ret
