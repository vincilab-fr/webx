# WebX Language Reference

## Overview

WebX is a compiled programming language designed for both native x86-64 and web (HTML/CSS/JS) targets. The language is a fork of KDX by Yug Merabtene.

## Syntax

### Functions

* `fn` keyword declares a function
* `main` is the entry point
* Return type is optional, defaults to `i32`

Example:
```webx
fn main() -> i32 { ... }
```

### Variables

* `let` keyword declares a variable
* Type is optional, defaults to `i32`

Example:
```webx
let x = 5;
```

### Control Flow

* `if` statement
* `else` keyword
* `while` loop

Example:
```webx
if x > 5 {
    println("x is greater than 5");
} else {
    println("x is less than or equal to 5");
}
```

### Output

* `println` macro prints to standard output

Example:
```webx
println("Hello, world!");
```

### Conditional Statements

* `if` statement
* `else` keyword
* `if` statement with multiple conditions

Example:
```webx
if x > 5 && y < 10 {
    println("x is greater than 5 and y is less than 10");
} else if x == 5 {
    println("x is equal to 5");
} else {
    println("x is less than 5 or y is greater than or equal to 10");
}
```

### Loops

* `while` loop

Example:
```webx
let i = 0;
while i < 10 {
    println(i);
    i += 1;
}
```

## Data Types

* `i32` integer type
* `f64` floating-point type

## Assembly

The WebX compiler generates x86-64 assembly code using NASM syntax.

## Web Target

The WebX compiler will generate HTML/CSS/JS code for the web target in the future.

## Examples

* `if_chain.webx` example demonstrates nested `if` statements

## Roadmap

* Finish AST to Assembly codegen
* Add support for web target

## Contributing

Contributions are welcome. Please submit pull requests with changes and a clear description of the changes.

## License

WebX is licensed under the MIT License.

## Copyright

Copyright (c) 2026 Samy Alderson

## Acknowledgments

This project is based on KDX by Yug Merabtene.