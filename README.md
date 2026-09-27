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
| 06 | `06-print-str/` | `print_str(char *s)` — scan for `\0`, length via pointer subtraction, `sys_write` |
| 07 | `07-str-len/` | `str_len(char *s)` — same scan, return count in `rax` instead of printing |

Goal: a minimal no-libc kit — string/memory/number helpers on raw syscalls so
future lessons can drop `printf`/`gcc` and link with `ld` only.

### Up next (planned)

| # | Lesson | Why it's needed without libc |
|---|--------|------------------------------|
| 08 | `print-int-signed` — negatives + auto-newline | Can't print errors, counts, or test results without signed output |
| 09 | `read-line` — `sys_read` stdin wrapper | Replaces `scanf`/`fgets`; unblocks interactive input |
| 10 | `atoi` — `str_to_int(char *s)` | Parse numbers from input/args without `atoi`/`strtol` |
| 11 | `memcpy` / `memset` | Every buffer program needs raw memory ops once libc is gone |
| 12 | `strcmp` / `strequ` | Arg parsing (`--help`), tests, any string logic |
| 13 | `print-hex` — `0x...` dump helper | Debug memory without `printf("%x")` |
| 14 | `exit` + `print-err` (stderr, `fd=2`) | Exit codes + error stream distinction libc hides |
| 15 | `argv-no-libc` — read `argc`/`argv` from `[rsp]` in `_start` | Gateway to fully standalone programs (no `main`) |
| 16 | `file-cat` — `sys_open`/`read`/`write`/`close` | First real multi-syscall program; proves `fopen`/`fread` unnecessary |
| 17 | `fib-nolibc` (capstone) — rewrite `03` with only own helpers | Proof the kit is complete: links with `ld`, zero libc |

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
./06-print-str/print-str
./07-str-len/str-len

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
  06-print-str/       print-str.asm, main.c, Makefile, README.md
  07-str-len/        str-len.asm, main.c, Makefile, README.md
```

Each example folder has its own README with Build / Run / How it works.

## Conventions used here

- NASM syntax (`nasm -felf64`) for everything except `01` (GAS demo).
- Functions follow System V AMD64: args in `rdi, rsi, rdx, rcx, r8, r9`, return in `rax`.
- Standalone programs use `_start` + syscalls and link with `ld`.
- Functions callable from C use global labels + `ret` and link with `gcc -no-pie`.
