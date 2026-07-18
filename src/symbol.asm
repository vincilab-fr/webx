section .data
; Symbol table data section
; This is where we store all the symbols, for now it's just a simple array
; of symbol structures. In the future we might want to consider using a
; more efficient data structure like a hash table.

symbol_table times 1024 db 0
; Reserve 1KB for the symbol table, we can always increase this later
; if needed.

section .bss
; Symbol table index, this keeps track of the current position in the
; symbol table.
symbol_index resq 1

section .text
; Initialize the symbol table, just set the index to 0.
global symbol_init
symbol_init:
    ; This was tricky, had to make sure we were using the right section
    ; and that the index was being set correctly.
    mov qword [symbol_index], 0
    ret

; Add a symbol to the symbol table.
global symbol_add
symbol_add:
    ; Not proud of this but it works, we're basically just copying the
    ; symbol structure into the symbol table and then incrementing the
    ; index.
    mov rsi, symbol_table
    mov rdx, [symbol_index]
    mov rcx, 16 ; size of the symbol structure
    mov rdi, [rsp + 8] ; symbol structure pointer
    rep movsb
    add qword [symbol_index], 16
    ret

; Get a symbol from the symbol table.
global symbol_get
symbol_get:
    ; This is a bit of a hack, we're just returning the address of the
    ; symbol in the symbol table. We should probably consider returning
    ; a copy of the symbol instead.
    mov rsi, symbol_table
    mov rdx, [rsp + 8] ; symbol index
    imul rdx, 16 ; calculate the offset
    lea rax, [rsi + rdx]
    ret

; Check if a symbol exists in the symbol table.
global symbol_exists
symbol_exists:
    ; This is a simple linear search, we should probably consider using
    ; a more efficient algorithm in the future.
    mov rsi, symbol_table
    mov rdx, [symbol_index]
    mov rcx, 16 ; size of the symbol structure
    mov rdi, [rsp + 8] ; symbol structure pointer
    .loop:
    cmp rdx, 0
    je .not_found
    mov r8, [rsi]
    cmp r8, [rdi]
    je .found
    add rsi, 16
    sub rdx, 16
    jmp .loop
    .found:
    mov rax, 1
    ret
    .not_found:
    mov rax, 0
    ret