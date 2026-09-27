# 03 — Fibonacci (NASM + printf)

Prints the first 90 Fibonacci numbers by calling C `printf` from assembly.

## Build / Run

```sh
make
./fib | head
```

## How it works

- `fib.asm` defines `main` (not `_start`) and links with `gcc -no-pie`.
- Loop counter in `ecx`, current/next in `rax`/`rbx`.
- Before `call printf`: saves caller-saved `rax`/`rcx` with `push`, sets `rdi=format`, `rsi=current`, zeroes `rax` (varargs rule), then restores after.
- `rbx` is callee-saved, so saved/restored with `push rbx ... pop rbx`.

## Key instructions

`push`, `pop`, `call`, `add`, `dec`, `jnz`, `xor`, `mov`.
