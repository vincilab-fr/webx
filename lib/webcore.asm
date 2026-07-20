; lib/webcore.asm
BITS 64

; Data section
section .data
    ; Global variables go here
    lexeme db 'lexeme', 0
    token db 'token', 0

; Text section
section .text
    global _start

_start:
    ; Initialize data
    mov rax, lexeme
    mov [rax], 'l'
    mov [rax + 1], 'e'
    mov [rax + 2], 'x'
    mov [rax + 3], 'e'
    mov [rax + 4], 'm'
    mov [rax + 5], 'e', 0

    ; Lexical analysis
    ; (Assuming lexer has been implemented in src/lexer.asm)
    call lexer

    ; Generate token
    ; (Assuming token generation has been implemented in lexer)
    mov rax, token
    mov [rax], 't'
    mov [rax + 1], 'o'
    mov [rax + 2], 'k'
    mov [rax + 3], 'e'
    mov [rax + 4], 'n', 0

    ; Print token
    mov rdi, token
    xor rax, rax
    mov rsi, 1
    mov rdx, 6
    call printf

    ; Exit program
    xor rax, rax
    xor rdi, rdi
    syscall

; External functions
extern printf

; Lexer function (assuming it's been implemented in src/lexer.asm)
lexer:
    ; TO DO: Implement lexer logic here
    ret