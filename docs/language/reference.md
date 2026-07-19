# Language Reference

This document defines the currently supported WebX syntax.

## Program Structure

- Top-level functions
- Class blocks (entrypoint bridge through `Main.main`)

## Function Declarations

Supported forms:

```webx
function int add(int a, int b) {
    return a + b;
}
```

```webx
function main(a: int, b: int) -> int {
    return a + b;
}
```

## Parameters

- Preferred: `type name`
- Compatibility: `name: type`

## Types

- `int`, `float`, `string`, `boolean`, `char`, `void`

## Statements

- Variable declaration: `type name = expr;`
- Return: `return expr;`
- Branching: `if (...) { ... } else { ... }`
- Looping: `while (...) { ... }`, `for (...; ...; ...) { ... }`

## Operators

- Arithmetic: `+ - * / %`
- Comparison: `== != < <= > >= === !==`
- Logical: `&& || !`
- Increment: `i++`, `i--`

## Entry Point

Supported entry forms:

```webx
function int main() {
    return 0;
}
```

```webx
class Main {
    public void main() {
        return;
    }
}
```

## Notes

- Semicolons are required.
- Conditions are intended to be boolean-strict.
