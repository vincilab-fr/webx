section .data
; WebX standard web library data section
html_doctype db 'DOCTYPE html', 0
html_open_tag db '<html>', 0
html_close_tag db '</html>', 0
head_open_tag db '<head>', 0
head_close_tag db '</head>', 0
body_open_tag db '<body>', 0
body_close_tag db '</body>', 0

section .text
; WebX standard web library code section
global webx_generate_html
webx_generate_html:
; generates basic HTML structure
; this was tricky, had to manually handle buffer sizes
    mov rdi, html_doctype
    call print_string
    mov rdi, html_open_tag
    call print_string
    mov rdi, head_open_tag
    call print_string
    mov rdi, head_close_tag
    call print_string
    mov rdi, body_open_tag
    call print_string
    ; add body content here
    mov rdi, body_close_tag
    call print_string
    mov rdi, html_close_tag
    call print_string
    ret

global webx_handle_css
webx_handle_css:
; handles CSS styles, not proud of this but it works
    ; read CSS file from disk
    ; parse CSS file
    ; apply CSS styles to HTML
    ret

global webx_js_interop
webx_js_interop:
; handles JavaScript interop, still a work in progress
    ; read JS file from disk
    ; parse JS file
    ; execute JS code
    ret

print_string:
; prints a null-terminated string to stdout
    mov rsi, rdi
    mov rdx, 0
    jmp .loop
.loop:
    cmp byte [rsi], 0
    je .end
    inc rdx
    inc rsi
    jmp .loop
.end:
    mov rax, 1          ; sys_write
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, rdx        ; string length
    syscall
    ret