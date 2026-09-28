global read_line

section .bss
    discard resb 1

section .text

; arguments to pass read syscall
; rax set as 0 to indicate read syscall 
; rdi unsigned int fd - 0 for stdin
; rsi char * buf - buffer to store input
; rdx size_t count - bytes read

read_line:
    ; ; first we get rdi from c as char * buf 
    ; ; second param from c would be rsi which is count
    ; we need to put 0 in rdi, prev rdi in rsi, prev rsi in rdx..
    ; maybe can do in reverse..
    ; read(0, buf, count)

    mov r8, rdi         ; store buff pointer to r8
    lea r9, [rsi - 1]   ; compute count - 1 and store it to r9
                        ; lea here is just because rsi is a register holding count 
                        ; cpu does address calcualtion with lea and stores it in r9 register
    dec rsi
    mov rax, 0          ; sys_read from ausyscall --dump
    mov rdx, r9         ; set count
    mov rsi, r8         ; set buff
    mov rdi, 0          ; set fd stdin 0
    syscall             ; do read syscall

    test rax, rax       ; check if rax is negative indicating error
    js .ret
    mov r10, rax        ; store bytes read in rcx
    xor rcx, rcx        ; initialize scan counter to 0
    .scan:
        cmp rcx, r10        ; check if we have counted until bytes read
        jge .full_check    ; if count reached bytes read count and not found newline go to full check
        cmp byte [r8 + rcx], 10 ; compare (buff pointer + counter)'s value with newline (curr char)
        je .finish     ; found newline before full so end
        inc rcx         ; increment counter
        jmp .scan       ; loop back to scan
    .full_check:
        ; if we reached bytes read count and no newline handle it
        cmp r10, r9
        jne .finish
    .drain:
        mov rax, 0      ; do a read again in loop
        mov rdi, 0      ; stdin
        lea rsi, [rel discard]  ;
        mov rdx, 1      ; read only one byte at a type to discard
        syscall

        test rax, rax   ; check if rax is 0 or negative
        jz .finish      ; if 0 means no bytes read so can be done
        js .drain_err   ; if negative caused an error while reading
        cmp byte [rel discard], 10  ; check if byte read is newline
        jne .drain      ; if its not read next byte again
        jmp .finish     ; if equal then go to finish
    .drain_err:
        cmp rax, -4     ; -EINTR
        je .drain
    .finish:
        mov byte [r8 + r10], 0
        mov rax, r10
    .ret:
        ret                 ; after read rax will have bytes read and buffer populated
