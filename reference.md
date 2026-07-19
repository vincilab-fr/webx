# WebX Language Reference
=========================

## Syntax
--------

WebX has a minimal syntax focused on conciseness and readability.

### Functions

*   `fn name(args) -> ret_type { ... }`: Define a function with the given name, arguments, and return type.
*   `main() { ... }`: The entry point of the program.

### Variables

*   `let name = value;`: Declare a variable with the given name and initial value.

### Control Flow

*   `if condition { ... } [else { ... }]`: Conditional statement with optional else clause.
*   `while condition { ... }`: Repeat a block of code while the condition is true.
*   `return value;`: Return from the current function with the given value.

### Types

*   `i32`: 32-bit integer type.
*   `str`: String type.

### Operators

*   `+`, `-`, `*`, `/`: Arithmetic operators.
*   `==`, `!=`, `<`, `>`, `<=`, `>=`: Comparison operators.
*   `&&`, `||`: Logical operators.

## Examples
--------

### Simple Function

```webx
fn greet(name str) -> i32 {
    println!("Hello, {}!", name);
    return 0;
}
```

### Conditional Statement

```webx
let x = 5;
if x > 10 {
    println!("x is greater than 10");
} else {
    println!("x is less than or equal to 10");
}
```

### Loop

```webx
let x = 0;
while x < 5 {
    println!("x is {}", x);
    x += 1;
}
```

## Implementation
---------------

The WebX compiler is implemented in x86-64 NASM assembly. The source code is divided into several modules:

*   `lib/webcore.asm`: WebX virtual machine core implementation.
*   `lib/core.asm`: WebX core implementation, including lexer, parser, and AST.
*   `src/lexer.asm`: Lexer implementation.
*   `src/ast.asm`: Abstract syntax tree implementation.
*   `src/codegen.asm`: Code generator implementation.
*   `src/symbol.asm`: Symbol table implementation.
*   `src/sema.asm`: Semantic analysis implementation.
*   `src/linker.asm`: Linker implementation.
*   `src/optimizer.asm`: Optimizer implementation.
*   `src/main.asm`: Main entry point of the compiler.
*   `src/asm/parser.asm`: Parser implementation for assembly code.
*   `scripts/secret_scan.py`: Secret scan script.
*   `build.sh`: Build script.
*   `install.sh`: Install script.
*   `test.sh`: Test script.
*   `quick_tests/run_quick_tests.sh`: Quick tests script.
*   `quick_tests/run_spec_tests.sh`: SPEC tests script.
*   `quick_tests/test_features.sh`: Feature tests script.
*   `scripts/install_git_hooks.sh`: Git hooks installation script.
*   `examples/if_chain.webx`: Example code for if statement testing.

## Credits
----------

WebX is a fork of KDX (KodPix) by Yug Merabtene. Yug Merabtene is the original author and must always be credited. Original KDX repo: https://github.com/yugmerabtene/KDX.