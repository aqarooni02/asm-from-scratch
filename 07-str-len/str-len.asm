global str_len

section .text

str_len:
   ; rdi holds address of str 
   mov rcx, rdi ; store it to rcx which will store the count
   cmp byte [rcx], 0
   jz .done
   .loop:
       inc rcx
       cmp byte [rcx], 0
       jnz .loop
    .done:
        mov rax, rcx
        sub rax, rdi
        ret

