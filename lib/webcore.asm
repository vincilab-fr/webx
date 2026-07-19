; lib/webcore.asm
; WebX standard web library
; Functions for HTML generation, CSS handling, JS interop

section .text
    global _webx_html_write
    global _webx_css_write
    global _webx_js_write

_webx_html_write:
    ; HTML output callback
    ; Parameters: rdi - HTML buffer, rsi - HTML string
    ; Returns: HTML buffer pointer
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; Allocate 128 bytes for the HTML buffer
    mov rax, 128
    mul rax
    push rax
    pop rdi
    push rdi
    pop rsi
    mov rax, 10
    syscall ; sys_brk
    mov rsi, rax
    mov rdi, rsi
    mov rsi, -1
    mov rdx, 0x20
    syscall ; sys_mmap

    ; Copy the HTML string to the buffer
    mov rsi, rsi
    mov rdi, rsi
    mov rcx, -1
    rep movsb

    ; Return the HTML buffer pointer
    mov rax, rsi
    leave
    ret

_webx_css_write:
    ; CSS output callback
    ; Parameters: rdi - CSS buffer, rsi - CSS string
    ; Returns: CSS buffer pointer
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; Allocate 128 bytes for the CSS buffer
    mov rax, 128
    mul rax
    push rax
    pop rdi
    push rdi
    pop rsi
    mov rax, 10
    syscall ; sys_brk
    mov rsi, rax
    mov rdi, rsi
    mov rsi, -1
    mov rdx, 0x20
    syscall ; sys_mmap

    ; Copy the CSS string to the buffer
    mov rsi, rsi
    mov rdi, rsi
    mov rcx, -1
    rep movsb

    ; Return the CSS buffer pointer
    mov rax, rsi
    leave
    ret

_webx_js_write:
    ; JS output callback
    ; Parameters: rdi - JS buffer, rsi - JS string
    ; Returns: JS buffer pointer
    push rbp
    mov rbp, rsp
    sub rsp, 32

    ; Allocate 128 bytes for the JS buffer
    mov rax, 128
    mul rax
    push rax
    pop rdi
    push rdi
    pop rsi
    mov rax, 10
    syscall ; sys_brk
    mov rsi, rax
    mov rdi, rsi
    mov rsi, -1
    mov rdx, 0x20
    syscall ; sys_mmap

    ; Copy the JS string to the buffer
    mov rsi, rsi
    mov rdi, rsi
    mov rcx, -1
    rep movsb

    ; Return the JS buffer pointer
    mov rax, rsi
    leave
    ret

section .data
    .text_end:
    .data_end:
; end of file