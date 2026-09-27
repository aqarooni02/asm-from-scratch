# x86-64 Linux / System V AMD64 Cheatsheet

## Function arguments

| Arg | Register |
|-----|----------|
| 1 | `rdi` |
| 2 | `rsi` |
| 3 | `rdx` |
| 4 | `rcx` |
| 5 | `r8` |
| 6 | `r9` |

Return value: `rax`.

## Register preservation

- Caller-saved: `rax rcx rdx rdi rsi r8 r9 r10 r11`
- Callee-saved: `rbx rbp r12 r13 r14 r15`
- Special: `rsp` stack pointer, `rbp` frame pointer (optional)

## Common instructions

| Instr | Meaning |
|-------|---------|
| `mov` | copy |
| `lea` | calculate address |
| `add` / `sub` | addition / subtraction |
| `imul` | multiplication |
| `cmp` / `test` | compare / test, set flags |
| `xor r,r` | zero register |
| `push` / `pop` | save / restore on stack |
| `call` / `ret` | call function / return |

## Conditionals

| Jump | Meaning |
|------|---------|
| `je` | `==` |
| `jne` | `!=` |
| `jl` | signed `<` |
| `jle` | signed `<=` |
| `jg` | signed `>` |
| `jge` | signed `>=` |
| `jz` / `jnz` | zero / nonzero |

Also: `cmovl` = conditional move if signed less (used in `05-max-of-three`).

## Memory

- `[rdi]` — value at address in `rdi`
- `[rdi + 8]` — 8 bytes after address in `rdi`

## Syscalls used in this repo

- `rax=1`: `sys_write(rdi=fd, rsi=buf, rdx=len)`
- `rax=60`: `sys_exit(rdi=status)`
