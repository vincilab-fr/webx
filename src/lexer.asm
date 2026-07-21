; src/lexer.asm
; Improved version of lexer code
; Copyright (c) 2026 Samy Alderson

section .text
global lexer

lexer:
    ; Read a character from the input file
    push rsi
    mov rsi, rdi
    mov rdi, 1
    mov rax, 0
    syscall
    pop rsi

    ; Check if we've reached the end of the file
    cmp al, 0
    je end_lexer

    ; Convert the character to a token type
    cmp al, 'a'
    jl skip_char
    cmp al, 'z'
    jg skip_char
    cmp al, '_'
    jne skip_char
    movzx eax, al
    sub eax, 0x61
    add eax, 0x09
    jmp process_token

skip_char:
    cmp al, '0'
    jl skip_char
    cmp al, '9'
    jg skip_char
    cmp al, '-'
    jne skip_char
    movzx eax, al
    sub eax, 0x30
    jmp process_token

skip_char:
    cmp al, '+'
    jne skip_char
    mov eax, 0x40

process_token:
    ; Convert token type to ASCII character
    add eax, 0x30
    mov [result], al

    ; Return the result
    mov rax, result
    ret

end_lexer:
    ; Return a special token to indicate the end of the file
    mov eax, 0xFF
    mov [result], al
    mov rax, result
    ret

section .data
result times 1 db 0