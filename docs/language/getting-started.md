# Getting Started

This guide gets you from source code to a running WebX program.

## Requirements

- Linux x86-64
- NASM 2.15+
- GNU `ld`

## Build the Compiler

```bash
./build.sh
```

The compiler binary is created as `./webx`.

## Compile and Run a Program

```bash
./webx examples/hello.webx -o hello
./hello
```

## Output Modes

- Assembly only:

```bash
./webx examples/hello.webx -S -o hello.s
```

- Object only:

```bash
./webx examples/hello.webx -c -o hello.o
```

## First Program

```webx
function int main() {
    println("Hello, WebX");
    return 0;
}
```

## Next Steps

- Language rules: `docs/language/reference.md`
- Error meanings: `docs/language/error-codes.md`
- Practical examples: `docs/language/cookbook.md`
