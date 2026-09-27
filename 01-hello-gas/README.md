# 01 — Hello with GAS

Same "Hi" program as `02`, but written in GAS (GNU `as`) Intel-syntax assembly.

## Build / Run

```sh
make
./hi
```

## How it works

- `hi.s` defines `_start` (no libc).
- `sys_write(1, msg, len)` prints `Hi`, then `sys_exit(0)`.
- Linked with `ld`, not `gcc`.

## Key instructions

`mov`, `lea`, `syscall`, `xor` (zeroing `rdi` for exit status).
