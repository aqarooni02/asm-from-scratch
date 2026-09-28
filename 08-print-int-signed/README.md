# 08 — print_int_signed (signed integers + newline)

Implements `void print_int_signed(int64_t n)` in NASM, called from C (`main.c`).
Handles negative inputs and appends a newline after every number.

## Build / Run

```sh
make
./print-int-signed
```

Expected output:

```
-123
123
-7688
```

## How it works

- Arg arrives in `rdi` per System V AMD64, moved to `rax` for division.
- A newline (`10`) is stored at the end of the buffer first, so every output is line-terminated and included in the length math. Buffer is 23 bytes: up to 19 digits + `'-'` + `'\n'`.
- Sign dispatch: `test rax,rax` → `js .negative` sets a flag (`r8b=1`); `jnz` sends nonzero positives to the loop; zero falls through and stores a single `'0'`.
- `.negative` falls straight through into the digit loop — negatives need the same conversion.
- Digit loop uses `cqo` + `idiv rcx` (signed division). Negative remainders are fixed with `neg dl` before adding `'0'`. Negating remainders instead of the input keeps `INT64_MIN` safe (negating it would overflow).
- After the loop, `'-'` is prepended only if the flag is set.
- Length = `(buffer + 23) - rsi`, then a single `sys_write(1, rsi, len)`.
- Ends with `ret`, not `sys_exit` — returns to the C caller.

## Key instructions

`test`, `js`, `jnz`, `jns`, `cqo`, `idiv`, `neg`, `dec`, `lea`, `sub`, `syscall`, `ret`.
