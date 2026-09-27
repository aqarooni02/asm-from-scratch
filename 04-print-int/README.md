# 04 — print_int (your first utility function)

Implements `void print_int(int64_t n)` in NASM, called from C (`main.c`).
No newline is printed — output is the raw digits.

## Build / Run

```sh
make
./print_int
```

`main.c` calls `print_int(123 + 123)` then `print_int(0)`, so expect `2460`
(no newline/separator — that is correct for this version).

## How it works

- Arg arrives in `rdi` per System V; moved to `rax` for `div`.
- Special case: input `0` prints a single `'0'`.
- Otherwise: repeated `div rcx` (`rcx=10`) — quotient in `rax`, remainder in `rdx`.
- `add dl, '0'`, fill `buffer` backwards from the end (`21` bytes in `.bss`).
- Length = `(buffer + 21) - rsi`, then `sys_write(1, rsi, len)`.
- Ends with `ret`, not `sys_exit` — returns to the C caller.

## Key instructions

`test`, `jnz`, `div`, `dec`, `lea`, `sub`, `syscall`, `ret`.
