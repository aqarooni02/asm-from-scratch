# 05 — maxofthree (asm function called from C)

Implements `int64_t maxofthree(int64_t a, int64_t b, int64_t c)` in NASM.

## Build / Run

```sh
make
./maxofthree
```

Expected output:

```
3
12
7
15
```

## How it works

- Args arrive in `rdi, rsi, rdx` per System V AMD64.
- `mov rax, rdi`, then `cmp rax, rsi` + `cmovl rax, rsi` (if `rax < rsi`, take `rsi`).
- Repeat against `rdx`. Result returned in `rax`.
- `main.c` exercises it with four test cases via `printf("%ld\n", ...)`.

## Key instructions

`mov`, `cmp`, `cmovl`, `ret`.
