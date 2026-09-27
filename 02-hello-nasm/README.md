# 02 — Hello with NASM

Minimal NASM program: raw Linux syscalls, no libc.

## Build / Run

```sh
make
./hi
```

## How it works

- `hi.asm`: `section .data` holds `msg` + `len`, `section .text` holds `_start`.
- `sys_write(1, msg, len)`, then `sys_exit(0)`.
- Assemble: `nasm -f elf64 hi.asm -o hi.o`, link: `ld hi.o -o hi`.

## Key instructions

`mov`, `lea`, `syscall`, `xor`.
