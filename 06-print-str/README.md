# 06 — print_str (print a null-terminated string)

Implements `void print_str(char *s)` in NASM, called from C (`main.c`).
No newline is added — the string must contain `\n` itself if you want one.

## Build / Run

```sh
make
./print-str
```

Expected output:

```
Hello World
This is string two
THREE
```

## How it works

- Arg (pointer to string) arrives in `rdi` per System V AMD64.
- Scan phase: walk `rcx` forward from the start pointer until the `\0` terminator; `rdx` is zeroed first.
- Length = (address of `\0`) - (start pointer), via `mov rdx, rcx` + `sub rdx, rsi`.
- `sys_write(1, rsi=start, rdx=len)` — note `rsi` is set from `rdi` before `rdi` is reused for the fd.
- Empty string prints nothing (length 0), then falls through to the write.
- Ends with `ret`, not `sys_exit` — returns to the C caller.

## Key instructions

`mov`, `cmp`, `inc`, `jz`, `jnz`, `sub`, `syscall`, `ret`.
