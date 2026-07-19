; WebX standard web library - functions for HTML generation, CSS handling, JS interop
; Author: Samy Alderson
; Based on: KDX (KodPix) by Yug Merabtene (https://github.com/yugmerabtene/KDX)
;
; This file contains production-quality x86-64 NASM assembly for the WebX compiler.
; It includes functions for HTML generation, CSS handling, and JS interop.
;
; Section ordering is critical: .text before .data.
; Correct label scoping is crucial for assembly code.
; Clear register usage is essential for maintainability and readability.

section .text
global webx_html_string
global webx_css_string
global webx_js_string

; webx_html_string - generates a string in the HTML format
;
; Parameters:
;   input  - input string to be converted to HTML format
;   output - output buffer to store the HTML string
;
; Returns:
;   The length of the generated HTML string.
webx_html_string:
    ; Save volatile registers
    push rbp
    push rsi
    push rdi
    push r8
    push r9

    ; Initialize output buffer
    mov rsi, output
    mov rdi, input
    mov r8, 0  ; output length
    mov r9, 0  ; HTML string length

loop_html_start:
    ; Get next character from input string
    mov al, [rdi]
    inc rdi

    ; Check for HTML special characters
    cmp al, '<'
    je html_special_char
    cmp al, '>'
    je html_special_char
    cmp al, '&'
    je html_special_char

    ; Copy character to output buffer
    mov [rsi], al
    inc rsi
    inc r8

    ; Check for null character
    cmp al, 0
    je html_end

    ; Increment HTML string length
    inc r9
    jmp loop_html_start

html_special_char:
    ; Handle HTML special characters
    ; '<' -> '&lt;'
    cmp al, '<'
    je html_lt
    ; '>' -> '&gt;'
    cmp al, '>'
    je html_gt
    ; '&' -> '&amp;'
    cmp al, '&'
    je html_amp

html_lt:
    ; Copy '&' to output buffer
    mov al, '&'
    mov [rsi], al
    inc rsi
    mov al, 'l'
    mov [rsi], al
    inc rsi
    mov al, 't'
    mov [rsi], al
    inc rsi
    mov al, ';'
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_html_start

html_gt:
    ; Copy '&' to output buffer
    mov al, '&'
    mov [rsi], al
    inc rsi
    mov al, 'g'
    mov [rsi], al
    inc rsi
    mov al, 't'
    mov [rsi], al
    inc rsi
    mov al, ';'
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_html_start

html_amp:
    ; Copy '&' to output buffer
    mov al, '&'
    mov [rsi], al
    inc rsi
    mov al, 'a'
    mov [rsi], al
    inc rsi
    mov al, 'm'
    mov [rsi], al
    inc rsi
    mov al, 'p'
    mov [rsi], al
    inc rsi
    mov al, ';'
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_html_start

html_end:
    ; Terminate output buffer with null character
    mov al, 0
    mov [rsi], al

    ; Restore volatile registers
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rbp

    ; Return output length
    mov rax, r8
    ret

section .data
input db "Hello, World!", 0
output db 0, 0

; webx_css_string - generates a string in the CSS format
;
; Parameters:
;   input  - input string to be converted to CSS format
;   output - output buffer to store the CSS string
;
; Returns:
;   The length of the generated CSS string.
webx_css_string:
    ; Save volatile registers
    push rbp
    push rsi
    push rdi
    push r8
    push r9

    ; Initialize output buffer
    mov rsi, output
    mov rdi, input
    mov r8, 0  ; output length
    mov r9, 0  ; CSS string length

loop_css_start:
    ; Get next character from input string
    mov al, [rdi]
    inc rdi

    ; Check for CSS special characters
    cmp al, '{'
    je css_special_char
    cmp al, '}'
    je css_special_char

    ; Copy character to output buffer
    mov [rsi], al
    inc rsi
    inc r8

    ; Check for null character
    cmp al, 0
    je css_end

    ; Increment CSS string length
    inc r9
    jmp loop_css_start

css_special_char:
    ; Handle CSS special characters
    ; '{' -> '{'
    cmp al, '{'
    je css_curly_brace
    ; '}' -> '}'
    cmp al, '}'
    je css_closing_brace

css_curly_brace:
    ; Copy '{' to output buffer
    mov al, '{'
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_css_start

css_closing_brace:
    ; Copy '}' to output buffer
    mov al, '}'
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_css_start

css_end:
    ; Terminate output buffer with null character
    mov al, 0
    mov [rsi], al

    ; Restore volatile registers
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rbp

    ; Return output length
    mov rax, r8
    ret

section .data
input db "body { background-color: red; }", 0
output db 0, 0

; webx_js_string - generates a string in the JavaScript format
;
; Parameters:
;   input  - input string to be converted to JavaScript format
;   output - output buffer to store the JavaScript string
;
; Returns:
;   The length of the generated JavaScript string.
webx_js_string:
    ; Save volatile registers
    push rbp
    push rsi
    push rdi
    push r8
    push r9

    ; Initialize output buffer
    mov rsi, output
    mov rdi, input
    mov r8, 0  ; output length
    mov r9, 0  ; JavaScript string length

loop_js_start:
    ; Get next character from input string
    mov al, [rdi]
    inc rdi

    ; Check for JavaScript special characters
    cmp al, '('
    je js_special_char
    cmp al, ')'
    je js_special_char

    ; Copy character to output buffer
    mov [rsi], al
    inc rsi
    inc r8

    ; Check for null character
    cmp al, 0
    je js_end

    ; Increment JavaScript string length
    inc r9
    jmp loop_js_start

js_special_char:
    ; Handle JavaScript special characters
    ; '(' -> '('
    cmp al, '('
    je js_open_parenthesis
    ; ')' -> ')'
    cmp al, ')'
    je js_closing_parenthesis

js_open_parenthesis:
    ; Copy '(' to output buffer
    mov al, '('
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_js_start

js_closing_parenthesis:
    ; Copy ')' to output buffer
    mov al, ')'
    mov [rsi], al
    inc rsi
    ; Increment output length
    inc r8
    jmp loop_js_start

js_end:
    ; Terminate output buffer with null character
    mov al, 0
    mov [rsi], al

    ; Restore volatile registers
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rbp

    ; Return output length
    mov rax, r8
    ret

section .data
input db "console.log('Hello, World!');", 0
output db 0, 0