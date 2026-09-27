# asm-from-scratch

Learning x86-64 assembly on Linux, from raw syscalls to writing basic
functions callable from C.

## Roadmap

| # | Folder | What you learn |
|---|--------|----------------|
| 01 | `01-hello-gas/` | Hello world with GAS (`as` + `ld`), `sys_write` / `sys_exit` |
| 02 | `02-hello-nasm/` | Same program with NASM syntax, `ld` without libc |
| 03 | `03-fibonacci/` | NASM + C library: call `printf` from asm, caller-saved registers, stack alignment |
| 04 | `04-print-int/` | Your first utility function: `print_int(int64)` — `div` loop, buffer handling, `sys_write`, `ret` (no exit) |
| 05 | `05-max-of-three/` | Pure computation function: `maxofthree(a, b, c)` — System V args (`rdi, rsi, rdx`), `cmp`/`cmovl`, return in `rax` |

Supporting doc: `docs/cheatsheet.md` (calling convention, registers, common instructions).

## Prerequisites

- x86-64 Linux
- `nasm`, `gcc`, `binutils` (`as`, `ld`), `make`

```sh
# Debian/Ubuntu
sudo apt install nasm gcc make binutils
```

## Quickstart

```sh
# build everything
make

# run each example
./01-hello-gas/hi
./02-hello-nasm/hi
./03-fibonacci/fib | head
./04-print-int/print_int
./05-max-of-three/maxofthree

# clean everything
make clean
```

Or build a single step:

```sh
make -C 04-print-int
./04-print-int/print_int
```

## Structure

```
asm-from-scratch/
  Makefile
  README.md
  .gitignore
  docs/
    cheatsheet.md
  01-hello-gas/       hi.s, Makefile, README.md
  02-hello-nasm/      hi.asm, Makefile, README.md
  03-fibonacci/       fib.asm, Makefile, README.md
  04-print-int/       print_int.asm, main.c, Makefile, README.md
  05-max-of-three/    maxofthree.asm, main.c, Makefile, README.md
```

Each example folder has its own README with Build / Run / How it works.

## Conventions used here

- NASM syntax (`nasm -felf64`) for everything except `01` (GAS demo).
- Functions follow System V AMD64: args in `rdi, rsi, rdx, rcx, r8, r9`, return in `rax`.
- Standalone programs use `_start` + syscalls and link with `ld`.
- Functions callable from C use global labels + `ret` and link with `gcc -no-pie`.
