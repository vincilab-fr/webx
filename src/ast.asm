; src/ast.asm

[section .text]
global ast_init

; Initialize AST node
; Parameters: None
; Returns: AST node address
ast_init:
    ; Allocate memory for AST node
    mov rax, 32 ; 32-byte alignment for struct
    sub rax, 1 ; Make room for null terminator
    add rax, 32 ; Align to 32-byte boundary
    shr rax, 6 ; Divide by 32 to get word count
    shl rax, 3 ; Multiply by 8 to get byte count
    sub rax, 1 ; Make room for null terminator
    ; Allocate memory for AST node
    push rax
    pop rcx
    ; Initialize AST node fields
    mov [rcx + 0], rax ; Child pointer
    mov [rcx + 8], rax ; Value pointer
    mov [rcx + 16], rax ; Type pointer
    mov [rcx + 24], rax ; Attributes pointer
    ; Return AST node address
    mov rax, rcx
    ret

[section .data]
ast_node_size db 32 ; Size of an AST node in bytes
ast_node_align db 32 ; Alignment of an AST node in bytes