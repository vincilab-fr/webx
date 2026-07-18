section .data
    ; webcore library version
    webcore_version db '1.0.0', 0

    ; html tags
    html_doctype db '<!DOCTYPE html>', 0
    html_html db '<html>', 0
    html_head db '<head>', 0
    html_title db '<title>', 0
    html_body db '<body>', 0
    html_div db '<div>', 0
    html_span db '<span>', 0
    html_p db '<p>', 0
    html_a db '<a href="', 0
    html_img db '<img src="', 0

    ; css styles
    css_style db '<style>', 0
    css_color db 'color: ', 0
    css_background db 'background-color: ', 0
    css_font_size db 'font-size: ', 0

section .bss
    ; buffer for html generation
    html_buffer resb 1024

section .text
    global webcore_init
    global webcore_generate_html
    global webcore_add_css

webcore_init:
    ; init webcore library
    ; this was tricky, had to manually set up the data sections
    mov eax, 0
    ret

webcore_generate_html:
    ; generate html string
    ; not proud of this but it works
    mov rdi, html_buffer
    mov rsi, html_doctype
    call strcpy
    mov rsi, html_html
    call strcat
    mov rsi, html_head
    call strcat
    mov rsi, html_title
    call strcat
    mov rsi, html_body
    call strcat
    mov eax, html_buffer
    ret

webcore_add_css:
    ; add css style to html string
    ; this could be optimized
    mov rdi, html_buffer
    mov rsi, css_style
    call strcat
    mov rsi, css_color
    call strcat
    mov rsi, css_background
    call strcat
    mov rsi, css_font_size
    call strcat
    mov eax, html_buffer
    ret

strcpy:
    ; copy string from rsi to rdi
    mov rcx, 0
.loop:
    mov cl, byte [rsi]
    mov byte [rdi], cl
    inc rdi
    inc rsi
    test cl, cl
    jnz .loop
    ret

strcat:
    ; concatenate string from rsi to rdi
    mov rcx, 0
.loop:
    mov cl, byte [rdi]
    test cl, cl
    jz .copy
    inc rdi
    jmp .loop
.copy:
    mov cl, byte [rsi]
    mov byte [rdi], cl
    inc rdi
    inc rsi
    test cl, cl
    jnz .copy
    ret