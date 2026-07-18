# WebX

> A compiled web programming language built on the shoulders of [KDX](https://github.com/yugmerabtene/KDX).

## Origin

WebX is a fork of [KDX (KodPix)](https://github.com/yugmerabtene/KDX), a compiled language and toolchain written in x86-64 NASM assembly by [Yug Merabtene](https://github.com/yugmerabtene). KDX provides the foundation: a compiler pipeline (.kdx -> .s/.o -> ELF binary), lexer, parser, AST, semantic analysis, and code generation -- all in assembly.

WebX takes this architecture and redirects it toward the web. The goal is to let you write business logic, CSS styling, and JavaScript interactivity in a single compiled language, then output HTML, CSS, and JavaScript. The compiler backend stays in assembly for performance.

**This project would not exist without Yug Merabtene's work on KDX.** The compiler architecture, the assembly-first approach, and the quality gates are all inherited from KDX.

## What WebX Is

- A compiled programming language with C-like syntax
- Compiler written in x86-64 NASM assembly (inherited from KDX)
- Targets web output: HTML structure, CSS styling, JavaScript behavior
- Also supports native binary output (Linux ELF, like KDX)
- Write one source file, get a complete web page or native program

## Project Structure

```
src/           Compiler source (NASM assembly)
lib/           Standard library modules
docs/          Language reference, design docs
examples/      Example WebX programs
quick_tests/   Test scripts
```

## Building

### Requirements

- Linux x86-64
- NASM 2.15+
- GNU ld (binutils)

### Build the compiler

```bash
./build.sh
```

### Compile a WebX file

```bash
# Native binary
./webx examples/hello.webx -o hello

# Web output (HTML/CSS/JS)
./webx examples/app.webx --target web -o dist/
```

## Credits

- **[Yug Merabtene](https://github.com/yugmerabtene)** -- Original author of [KDX (KodPix)](https://github.com/yugmerabtene/KDX), which this project is forked from. The entire compiler architecture, assembly-first design, and quality infrastructure come from KDX.
- **Samy Alderson** -- WebX adaptation, web target development, and ongoing maintenance.

## License

GPLv3 (inherited from KDX)
