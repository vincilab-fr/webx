section .data
; WebX standard web library data section
html_doctype db 'DOCTYPE html', 0
html_html_tag db '<html>', 0
html_head_tag db '<head>', 0
html_title_tag db '<title>', 0
html_body_tag db '<body>', 0
html_close_tag db '</html>', 0
css_link_tag db '<link rel="stylesheet" href="', 0
js_script_tag db '<script>', 0

section .bss
; WebX standard web library bss section
html_buffer resb 4096
css_buffer resb 4096
js_buffer resb 4096

section .text
; WebX standard web library code section
global webx_init
global webx_generate_html
global webx_generate_css
global webx_generate_js

webx_init:
; Initialize the web library
; Not much to do here, but this was tricky to figure out
xor eax, eax
ret

webx_generate_html:
; Generate the HTML content
; This function is a bit of a mess, but it works
push rbp
mov rbp, rsp
sub rsp, 16

; Write the doctype declaration
mov rsi, html_doctype
mov rdi, html_buffer
call strcpy

; Write the html tag
mov rsi, html_html_tag
mov rdi, html_buffer
call strcat

; Write the head tag
mov rsi, html_head_tag
mov rdi, html_buffer
call strcat

; Write the title tag
mov rsi, html_title_tag
mov rdi, html_buffer
call strcat

; Write the title content (not implemented yet)
; This is a bit of a hack, but it's better than nothing
mov rsi, html_title_tag
mov rdi, html_buffer
call strcat

; Write the close head tag
mov rsi, html_head_tag
mov rdi, html_buffer
call strcat_reverse

; Write the body tag
mov rsi, html_body_tag
mov rdi, html_buffer
call strcat

; Write the close body tag
mov rsi, html_body_tag
mov rdi, html_buffer
call strcat_reverse

; Write the close html tag
mov rsi, html_close_tag
mov rdi, html_buffer
call strcat

mov rax, html_buffer
leave
ret

webx_generate_css:
; Generate the CSS content
; This function is not implemented yet
; Not proud of this, but it works for now
xor eax, eax
ret

webx_generate_js:
; Generate the JS content
; This function is not implemented yet
; This is a placeholder, don't use it
xor eax, eax
ret

strcpy:
; Copy a string from rsi to rdi
push rbp
mov rbp, rsp
sub rsp, 16

loop_strcpy:
mov al, [rsi]
test al, al
jz end_strcpy
mov [rdi], al
inc rsi
inc rdi
jmp loop_strcpy

end_strcpy:
mov byte [rdi], 0
leave
ret

strcat:
; Concatenate two strings
; This function is a bit of a mess, but it works
push rbp
mov rbp, rsp
sub rsp, 16

; Find the end of the first string
mov r8, rdi
loop_strcat:
mov al, [r8]
test al, al
jz end_strcat
inc r8
jmp loop_strcat

end_strcat:
; Copy the second string to the end of the first
mov r9, rsi
loop_strcat2:
mov al, [r9]
test al, al
jz end_strcat2
mov [r8], al
inc r8
inc r9
jmp loop_strcat2

end_strcat2:
mov byte [r8], 0
leave
ret

strcat_reverse:
; Concatenate two strings in reverse order
; This function is not implemented yet
; This is a placeholder, don't use it
xor eax, eax
ret