# CS 440/540 Program #4: Rusty to x86-64

This program translates a Rusty source file on `stdin` to x86-64 GAS
assembly on `stdout`, suitable for linking with the provided
`rusty_main.c` driver.

## Files

- `rusty.l`    - flex lexer
- `rusty.y`    - bison grammar with attached code-generation actions
- `stab.c/h`   - symbol table (scopes, variables, functions)
- `codegen.c/h`- register allocator and x86-64 emission helpers
- `Makefile`   - build rules
- `rusty_main.c` - C driver (`rusty_main` entry, `printf` format strings
  `S0`/`S1`, and `rusty_input`). This version reads integers from stdin
  with `scanf` when stdin is redirected from a file or pipe, and falls
  back to the original pseudo-random behaviour when run interactively.

## Build

```
make
```

This produces the `rusty` executable.

## Use

```
./rusty < program.r > program.s
gcc -o a.out rusty_main.c program.s

# Interactive (random inputs), or pass an upper bound:
./a.out
./a.out 100

# Reading integers from a file:
./a.out < input.txt
```

A shortcut target is provided:

```
make run PROG=../rusty_code/sort.r
./a.out < ../rusty_code/sort.txt
```

## Coverage (per assignment)

- Output: `print(int)`, `print(str)`, `println(int)`, `println(str)`
- Arithmetic: `+ - * / %` with constants and variables
- Relational / boolean: `== != < <= > >= && || !`
- Procedure call and return (with up to 6 parameter registers)
- Local variables with nested `{ ... }` scopes (per-scope offsets
  tracked through `current_named_scope->var_ctr`)
- `read()` calling `rusty_input`
- `if` / `else` and `while`, including nesting
- 1-D integer arrays allocated with `calloc`

## Register convention

Temporary registers used by the generated code:

    %r10d %r11d %ebx %ebp %r12d %r13d %r14d %r15d

Parameters are kept in their incoming registers (`%edi, %esi, %edx,
%ecx, %r8d, %r9d`) and referenced directly. Every function reserves
a 128-byte stack frame; slots 64..127 are used for caller-save
spills of `%rdi..%r11` around each call, and slots 0..63 hold local
variables (int = 4 bytes, array pointer = 8 bytes).
