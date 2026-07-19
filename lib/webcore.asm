section .text
global html_init
global css_init
global js_init
global html_close

html_init:
    ; Initialize HTML generator
    ; Create HTML header with doctype, title, and charset
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    mov rsi, html_header  ; string to write
    mov rdx, html_header_len
    syscall

    ; Initialize CSS generator (empty for now)
    ; Create <style> tag
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    mov rsi, css_header   ; string to write
    mov rdx, css_header_len
    syscall
    ret

css_init:
    ; Initialize CSS generator
    ; Create empty <style> tag
    ; (no-op for now, just a placeholder)
    ret

js_init:
    ; Initialize JavaScript generator
    ; Create <script> tag
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    mov rsi, js_header    ; string to write
    mov rdx, js_header_len
    syscall
    ret

html_close:
    ; Close HTML document
    ; Create </html> tag
    mov rax, 1            ; sys_write
    mov rdi, 1            ; stdout
    mov rsi, html_footer  ; string to write
    mov rdx, html_footer_len
    syscall
    ret

section .data
html_header db '<!DOCTYPE html><html><head><title>WebX</title><meta charset="utf-8">', 0
html_header_len equ $ - html_header

css_header db '<style>', 0
css_header_len equ $ - css_header

js_header db '<script>', 0
js_header_len equ $ - js_header

html_footer db '</html>', 0
html_footer_len equ $ - html_footer