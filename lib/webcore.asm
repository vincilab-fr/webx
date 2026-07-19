section .text
global _start

_start:
    ; Load HTML template into memory
    mov rsi, html_template
    mov rdi, 0x1000
    mov eax, 0x1 ; sys_read
    syscall

html_template:
    db 'html>', 0

; Generate HTML tag
generate_tag:
    ; Load tag name into eax
    mov eax, 0x68 ; 'h'
    mov [r12], eax ; Store tag name in r12
    ; Load closing tag name into eax
    mov eax, 0x68 ; 'h'
    mov [r13], eax ; Store closing tag name in r13

generate_tag_loop:
    ; Generate opening tag
    mov eax, [r12]
    mov [r12], eax ; Shift tag name to the left
    sub eax, 0x68 ; Remove last character
    mov byte [r12], al
    ; Generate closing tag
    mov eax, [r13]
    mov [r13], eax ; Shift closing tag name to the left
    sub eax, 0x68 ; Remove last character
    mov byte [r13], al
    ; Check if tag name is empty
    cmp byte [r12], 0
    jz generate_tag_end
    jmp generate_tag_loop

generate_tag_end:
    ; Generate HTML document
    mov rsi, html_document
    mov rdi, 0x1000
    mov eax, 0x1 ; sys_write
    syscall

html_document:
    db '<!DOCTYPE html>', 0
    db '<html>', 0
    db '<body>', 0
    db '<h1>Hello, World!</h1>', 0
    db '</body>', 0
    db '</html>', 0

section .data

section .bss
    resb 0x1000 ; Reserve 4KB for HTML template

section .rodata
    html_template db 'html>', 0
    html_document db '<!DOCTYPE html>', 0
    db '<html>', 0
    db '<body>', 0
    db '<h1>Hello, World!</h1>', 0
    db '</body>', 0
    db '</html>', 0