global print_str

section .text

print_str:
    mov rcx, rdi        ; stores starting pointer
    xor rdx, rdx        ; reset rdx to 0
    cmp byte [rcx], 0   ; compare "byte" needed
    jz .print
    .loop:
        inc rcx
        cmp byte [rcx], 0
        jnz .loop
    .print:
        mov rax, 1      ; syscall write
        mov rsi, rdi    ; write rdi (Start pointer) to char * second parameter
        mov rdi, 1      ; stdout first parameter now rdi was overriden with 1
                        ; thats why we moved rdi to rsi first
        mov rdx, rcx    ; rcx stores the position of the '\0'
        sub rdx, rsi    ; we put it in rdx then subtract start pos from it
        syscall
        ret
