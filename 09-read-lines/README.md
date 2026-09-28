# 09 — read_line (line input on raw syscalls)

Implements `ssize_t read_line(char *buf, size_t cap)` in NASM, called from C
(`main.c`). Reads one line from stdin, always NUL-terminates, and returns the
byte count (excluding NUL). Requires `cap >= 2`.

## Build / Run

```sh
make
./read-lines
```

Example session (type a short line, then a >99-char line, then Ctrl-D):

```
hello
bytes read: 6
buf with nul byte: hello
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
bytes read: 99
buf with nul byte: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```

## Contract

- `cap` is the full buffer size; at most `cap - 1` bytes are stored so
  `buf[n] = 0` always fits. `cap < 2` is rejected (a count of 1 could only hold
  the NUL); the caller passes `sizeof(buf)`, never more.
- Return value: bytes stored, excluding the NUL, including `'\n'` if present.
  `0` = EOF (a lone Enter gives `1` containing just `'\n'`, so `0` means EOF
  unambiguously). Negative = `-errno` propagated untouched, buffer left alone.
- Over-long lines are silently truncated: what fits is returned, the rest of
  the line is drained and discarded, so the next call sees fresh input.

## How it works

One `sys_read` first, loops only when needed:

1. **Setup.** `buf` is parked in `r8`, `cap - 1` computed into `r9` with `lea`
   (plain arithmetic — the brackets just mean "evaluate this"). Both survive
   `syscall`, which clobbers only `rax/rcx/r11`. One `read(0, buf, cap-1)`.
2. **Error/EOF passthrough.** Negative `rax` returns as-is. `0` skips ahead to
   NUL-terminate `buf[0]` and return 0.
3. **Scan.** Walk the `n` bytes actually read (`rcx` counts up to `n` in
   `r10`) comparing each against `10` (`'\n'`). Only returned bytes are
   examined — past `n` is stale stack garbage. Found → done.
4. **Short read, no newline** (`n < cap-1`): EOF tail or pipe fragment —
   returned as-is, NUL-terminated. A single `read` cannot tell "final line
   without newline" from "short chunk", so this is documented, not solved.
5. **Full buffer, no newline** (`n == cap-1`): overflow. The **drain loop**
   reads 1 byte at a time into a 1-byte `.bss` scratch (`discard` — the real
   buffer is full, so there is nowhere else to put them) until `'\n'` or EOF,
   throwing everything away. `-EINTR` retries; any other error stops the drain
   and keeps what was stored. There is no "flush stdin" syscall — draining
   *is* flushing.
6. **Finish.** `buf[n] = 0` (always fits since `n <= cap-1`), return `n`.

## Two bugs found while building this

- `dec rdi` vs `dec rsi`: decrementing the *pointer* (`rdi` = buf) instead of
  the *count* (`rsi`) made the kernel write one byte before the array → stack
  corruption → segfault. Pointers and counts must never be confused.
- Wild `rcx`: `syscall` clobbers `rcx`/`r11` on *every* invocation, so the
  drain loop destroyed the byte count `n` and `.finish` wrote the NUL to a
  garbage address (gdb showed `rcx = 0x4011d5`, a code address). Fix: `n`
  lives in `r10` (syscall-preserved), `rcx` is only the disposable scan index.
  Rule: `rcx`/`r11` die on every `syscall`; `r8–r10` survive it.

## Key instructions

`lea`, `syscall`, `test`, `js`, `jz`, `cmp`, `jge`, `je`, `jne`, `inc`, `ret`.

## Known limitation

The drain costs one syscall per excess byte — but only on the overflow path.
A fitting line costs exactly 1 syscall total. A chunked drain (e.g. 64-byte
scratch with a scan per chunk) or a persistent buffered reader would reduce
overflow-path syscalls; both are deferred as follow-up lessons.
