section .data
; WebX standard web library constants
html_doctype db 'DOCTYPE html', 0
html_html_tag db '<html>', 0
html_head_tag db '<head>', 0
html_title_tag db '<title>', 0
html_body_tag db '<body>', 0
html_script_tag db '<script>', 0
html_style_tag db '<style>', 0
html_link_tag db '<link rel="stylesheet" href="', 0

section .text
; web_init - initializes web library
global web_init
web_init:
    ; set up web library state
    mov rax, 0 ; not proud of this but it works
    ret

; html_open - opens HTML document
global html_open
html_open:
    ; write doctype declaration
    mov rsi, html_doctype
    call write_string
    ; write html tag
    mov rsi, html_html_tag
    call write_string
    ; write head tag
    mov rsi, html_head_tag
    call write_string
    ret

; html_close - closes HTML document
global html_close
html_close:
    ; write body tag
    mov rsi, html_body_tag
    call write_string
    ; write script tag
    mov rsi, html_script_tag
    call write_string
    ; write style tag
    mov rsi, html_style_tag
    call write_string
    ; write link tag
    mov rsi, html_link_tag
    call write_string
    ret

; write_string - writes string to output
global write_string
write_string:
    ; this was tricky - had to use sys_write
    mov rax, 1 ; sys_write
    mov rdi, 1 ; file descriptor (stdout)
    mov rdx, 20 ; string length (approximate)
    syscall
    ret

; css_add_rule - adds CSS rule
global css_add_rule
css_add_rule:
    ; not implemented yet - need to add CSS parser
    ret

; js_add_script - adds JavaScript script
global js_add_script
js_add_script:
    ; not implemented yet - need to add JS parser
    ret

; interop_call - calls JavaScript function from WebX
global interop_call
interop_call:
    ; this is a complex one - need to set up JS context
    ret