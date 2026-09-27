# 07 — str_len (string length)

Implements `uint64_t str_len(char *s)` in NASM, called from C (`main.c`).
Returns the number of bytes before the `\0` terminator (terminator not counted).

## Build / Run

```sh
make
./str-len
```

Expected output:

```
5
```

## How it works

- Arg (pointer to string) arrives in `rdi` per System V AMD64.
- Copy the start pointer to `rcx`, then walk `rcx` forward until `byte [rcx]` is `\0` (`cmp` + `jnz` loop).
- Empty string skips the loop via the upfront `jz .done` check.
- Length = (address of `\0`) - (start pointer), via `mov rax, rcx` + `sub rax, rdi`.
- Result returned in `rax`; ends with `ret` — returns to the C caller.
- `main.c` checks it against `"Hello"` and prints the result with `printf("%lu\n", ...)`.

## Key instructions

`mov`, `cmp`, `inc`, `jz`, `jnz`, `sub`, `ret`.
