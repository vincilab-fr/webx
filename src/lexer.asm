; lexer.asm

section .text
global lexer
lexer:
    ; Input: RDI = input string
    ; Output: RAX = token type, RDX = token value

    ; Check if input is empty
    cmp byte [rdi], 0
    je done

    ; Check if input starts with a keyword
    cmp byte [rdi], 'f'
    je fn_keyword
    cmp byte [rdi], 'l'
    je let_keyword
    cmp byte [rdi], 'p'
    je println_keyword
    cmp byte [rdi], 'i'
    je if_keyword
    cmp byte [rdi], 'w'
    je while_keyword
    cmp byte [rdi], 'r'
    je return_keyword
    jmp other_token

fn_keyword:
    ; Check if input is "fn"
    mov rax, 1 ; token type: function
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    cmp rdx, 2
    jne other_token
    mov rax, 1 ; token type: function
    mov rdx, 0 ; token value: none
    jmp done

let_keyword:
    ; Check if input is "let"
    mov rax, 2 ; token type: let
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    cmp rdx, 3
    jne other_token
    mov rax, 2 ; token type: let
    mov rdx, 0 ; token value: none
    jmp done

println_keyword:
    ; Check if input is "println"
    mov rax, 3 ; token type: println
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    cmp rdx, 7
    jne other_token
    mov rax, 3 ; token type: println
    mov rdx, 0 ; token value: none
    jmp done

if_keyword:
    ; Check if input is "if"
    mov rax, 4 ; token type: if
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    cmp rdx, 2
    jne other_token
    mov rax, 4 ; token value: none
    jmp done

while_keyword:
    ; Check if input is "while"
    mov rax, 5 ; token type: while
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    cmp rdx, 5
    jne other_token
    mov rax, 5 ; token value: none
    jmp done

return_keyword:
    ; Check if input is "return"
    mov rax, 6 ; token type: return
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    cmp rdx, 6
    jne other_token
    mov rax, 6 ; token value: none
    jmp done

other_token:
    ; Check if input is a number
    mov rax, 0 ; token type: number
    mov rdx, 0 ; token value: none
    cmp byte [rdi], '0'
    jl invalid_token
    cmp byte [rdi], '9'
    jg invalid_token
    ; Check if input is a string
    mov rax, 7 ; token type: string
    mov rdx, 0 ; token value: none
    mov rsi, rdi
    call str_len
    mov rdx, rax ; get length
    jmp done

invalid_token:
    ; Unknown token, print error message
    mov rax, 8 ; token type: error
    mov rdx, 0 ; token value: none
    jmp done

done:
    ; Return token type and value
    ret

str_len:
    ; Return length of input string
    xor rax, rax
    mov r8, 0
    .loop:
        cmp byte [rdi + r8], 0
        je .done
        inc r8
        jmp .loop
    .done:
        ret