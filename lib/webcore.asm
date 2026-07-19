section .text
global printf
printf:
    ; printf function to output a formatted string
    ; This is a simplified version for now
    ; WebX will need a more robust version
    ; that handles formatting and escapes

    ; Load the format string
    mov rsi, rdi

    ; Load the string to print
    mov rdi, fmt_str
    ; Load the format string address into rsi
    mov rsi, rdi

    ; Call the libc printf function
    mov rax, 0x2000004
    syscall

    ; Return success
    ret

section .data
fmt_str db "Hello, World!", 0

; WebX standard library functions

; HTML generation

global html_tag
html_tag:
    ; Tag is a string
    ; We will add more HTML functions later
    ; For now, we just return the tag
    ; and the user needs to add the rest
    mov rdi, rsi
    ret

; CSS handling

global css_rule
css_rule:
    ; CSS rule is a string
    ; We will add more CSS functions later
    ; For now, we just return the rule
    ; and the user needs to add the rest
    mov rdi, rsi
    ret

; JavaScript interop

global js_import
js_import:
    ; Import a JavaScript module
    ; We will add more JavaScript functions later
    ; For now, we just return the module
    ; and the user needs to add the rest
    mov rdi, rsi
    ret

global js_eval
js_eval:
    ; Evaluate a JavaScript expression
    ; We will add more JavaScript functions later
    ; For now, we just return the result
    ; and the user needs to add the rest
    mov rdi, rsi
    ret