; lexer.asm
; WebX lexer written in NASM assembly

section .text
global lexer
lexer:
    ; Initialize lexer state
    mov rdi, [rsp + 8]      ; input pointer
    mov rsi, [rsp + 16]     ; token buffer
    mov rdx, [rsp + 24]     ; token length
    mov rcx, [rsp + 32]     ; max token length
    mov r8, 0               ; token start index
    mov r9, 0               ; token end index

    ; Loop through input characters
loop_lexer:
    mov r10b, [rdi]         ; get input character
    cmp r10b, 0             ; EOF?
    jz lexer_end            ; yes, end lexer
    cmp r10b, 32            ; whitespace?
    jz loop_lexer           ; yes, skip
    cmp r10b, 9             ; tab?
    jz loop_lexer           ; yes, skip
    cmp r10b, 13            ; newline?
    jz loop_lexer           ; yes, skip

    ; Check for token start
    cmp r8, 0               ; first token?
    jne check_token_start    ; no, check if token start

    ; Check if input character is a valid token start
    ; TODO: replace with actual lexer logic
    cmp r10b, 65            ; A
    jl loop_lexer           ; no, skip
    cmp r10b, 90            ; Z
    jg loop_lexer           ; no, skip
    cmp r10b, 97            ; a
    jl loop_lexer           ; no, skip
    cmp r10b, 122           ; z
    jg loop_lexer           ; no, skip
    jmp check_token_start

check_token_start:
    ; Check if input character is a valid token end
    ; TODO: replace with actual lexer logic
    cmp r10b, 65            ; A
    jl skip_token_end       ; no, skip
    cmp r10b, 90            ; Z
    jg skip_token_end       ; no, skip
    cmp r10b, 97            ; a
    jl skip_token_end       ; no, skip
    cmp r10b, 122           ; z
    jg skip_token_end       ; no, skip

    ; Get token end index
    mov r9, r8
    inc r8
    loop_lexer_next:

    ; Check if token end index exceeds max token length
    cmp r8, rcx
    jge lexer_error

    ; Get input character at token end index
    mov r10b, [rdi + r8]

    ; Check if input character is a valid token end
    cmp r10b, 32            ; whitespace?
    jne check_token_end      ; no, check
    cmp r10b, 9             ; tab?
    jne check_token_end      ; no, check
    cmp r10b, 13            ; newline?
    jne check_token_end      ; no, check

    ; Check if token end index exceeds max token length
    cmp r8, rcx
    jge lexer_error

    ; Check if input character is a valid token end
    cmp r10b, 65            ; A
    jl check_token_end      ; no, check
    cmp r10b, 90            ; Z
    jg check_token_end      ; no, check
    cmp r10b, 97            ; a
    jl check_token_end      ; no, check
    cmp r10b, 122           ; z
    jg check_token_end      ; no, check

check_token_end:
    ; Store token end index
    mov [rdx + r9], r8

    ; Increment token length
    inc r9

    ; Check if token length exceeds max token length
    cmp r9, rcx
    jge lexer_error

    ; Check if token length is zero
    cmp r9, 0
    jge lexer_error

    ; Return token length
    mov rax, r9
    jmp lexer_end

skip_token_end:
    ; Skip input character
    inc r8
    jmp loop_lexer_next

lexer_error:
    ; Return lexer error code
    mov rax, -1
    jmp lexer_end

lexer_end:
    ; Restore input pointer
    mov [rsp + 8], rdi

    ; Restore token buffer
    mov [rsp + 16], rsi

    ; Restore token length
    mov [rsp + 24], rdx

    ; Restore max token length
    mov [rsp + 32], rcx

    ; Return lexer result
    ret