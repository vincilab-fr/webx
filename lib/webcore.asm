; lib/webcore.asm - WebX standard web library
; functions for HTML generation, CSS handling, JS interop
;
; This file is part of the WebX compiler, a fork of KDX (KodPix) by Yug Merabtene.
; I've adapted it toward web output, but the core assembly-first design remains the same.
; Thanks to Yug for the original work - this wouldn't be possible without KDX.

section .data
    ; HTML tags
    html_tag db 'html', 0
    head_tag db 'head', 0
    body_tag db 'body', 0
    ; CSS properties
    color_prop db 'color', 0
    background_prop db 'background-color', 0
    ; JS keywords
    let_kw db 'let', 0
    const_kw db 'const', 0

section .text
    global web_init
    global html_open
    global html_close
    global css_property
    global js_variable

web_init:
    ; Initialize the web library
    ; This is called once at the start of the program
    ; Not much to do here, but it's a good place to put any future init code
    ret

html_open:
    ; Open an HTML tag
    ; Args: tag name (string)
    ; Returns: none
    push rbp
    mov rbp, rsp
    sub rsp, 16
    ; Save the tag name
    mov [rbp - 8], rdi
    ; Print the opening tag
    mov rsi, [rbp - 8]
    mov rdx, 0
    call print_string
    mov rsi, html_tag
    mov rdx, 5
    call print_string
    ; This was tricky - getting the tag name to print correctly
    mov byte [rbp - 16], '>'
    mov rsi, rbp
    mov rdx, 1
    call print_string
    leave
    ret

html_close:
    ; Close an HTML tag
    ; Args: tag name (string)
    ; Returns: none
    push rbp
    mov rbp, rsp
    sub rsp, 16
    ; Save the tag name
    mov [rbp - 8], rdi
    ; Print the closing tag
    mov byte [rbp - 16], '<'
    mov rsi, rbp
    mov rdx, 1
    call print_string
    mov rsi, html_tag
    mov rdx, 5
    call print_string
    mov byte [rbp - 16], '>'
    mov rsi, rbp
    mov rdx, 1
    call print_string
    leave
    ret

css_property:
    ; Set a CSS property
    ; Args: property name (string), value (string)
    ; Returns: none
    push rbp
    mov rbp, rsp
    sub rsp, 32
    ; Save the property name and value
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    ; Print the property name
    mov rsi, [rbp - 8]
    mov rdx, 0
    call print_string
    ; Print the colon and space
    mov byte [rbp - 32], ':'
    mov rsi, rbp
    mov rdx, 1
    call print_string
    mov byte [rbp - 32], ' '
    mov rsi, rbp
    mov rdx, 1
    call print_string
    ; Print the value
    mov rsi, [rbp - 16]
    mov rdx, 0
    call print_string
    ; Print the semicolon
    mov byte [rbp - 32], ';'
    mov rsi, rbp
    mov rdx, 1
    call print_string
    leave
    ret

js_variable:
    ; Declare a JS variable
    ; Args: variable name (string), value (string)
    ; Returns: none
    push rbp
    mov rbp, rsp
    sub rsp, 32
    ; Save the variable name and value
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    ; Print the let keyword
    mov rsi, let_kw
    mov rdx, 3
    call print_string
    ; Print the variable name
    mov rsi, [rbp - 8]
    mov rdx, 0
    call print_string
    ; Print the equals sign and space
    mov byte [rbp - 32], '='
    mov rsi, rbp
    mov rdx, 1
    call print_string
    mov byte [rbp - 32], ' '
    mov rsi, rbp
    mov rdx, 1
    call print_string
    ; Print the value
    mov rsi, [rbp - 16]
    mov rdx, 0
    call print_string
    ; Print the semicolon
    mov byte [rbp - 32], ';'
    mov rsi, rbp
    mov rdx, 1
    call print_string
    leave
    ret

print_string:
    ; Print a string to the output
    ; Args: string (pointer), length (integer)
    ; Returns: none
    ; Not proud of this, but it works for now
    mov rax, 1
    mov rdi, 1
    syscall
    ret