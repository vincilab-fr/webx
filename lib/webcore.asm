section .data
; webcore data section, holds constants and initial values
; this section is initialized at compile time
webcore_version db '1.0.0', 0
webcore_author db 'Yug Merabtene (original author), Samy Alderson (fork maintainer)', 0

section .bss
; webcore bss section, holds uninitialized data
; this section is initialized at runtime
webcore_buffer resb 1024
webcore_err_msg resb 256

section .text
; webcore code section, holds the program logic
global webcore_init
global webcore_compile
global webcore_error

webcore_init:
; initialize webcore, set up buffer and error message
; this was tricky, had to get the buffer sizes just right
mov rdi, webcore_buffer
mov rsi, 0
mov rcx, 1024
rep stosb
mov rdi, webcore_err_msg
mov rsi, 0
mov rcx, 256
rep stosb
ret

webcore_compile:
; compile webx code, generate html/css/js output
; not proud of this but it works, need to refactor later
push rbp
mov rbp, rsp
sub rsp, 16
mov rdi, [rbp + 16]
mov rsi, [rbp + 24]
call webcore_lexer
call webcore_ast
call webcore_codegen
add rsp, 16
pop rbp
ret

webcore_error:
; handle webcore errors, print error message
; need to improve error handling, this is just a start
mov rdi, webcore_err_msg
mov rsi, [rbp + 16]
call printf
ret

webcore_lexer:
; lex webx code, break into tokens
; this is a basic lexer, need to add more token types
mov rdi, [rbp + 16]
mov rsi, webcore_buffer
call lexer_loop
ret

webcore_ast:
; parse webx tokens, build ast
; this is a basic parser, need to add more node types
mov rdi, [rbp + 16]
mov rsi, webcore_buffer
call parser_loop
ret

webcore_codegen:
; generate html/css/js output from ast
; this is a basic code generator, need to add more output types
mov rdi, [rbp + 16]
mov rsi, webcore_buffer
call codegen_loop
ret

lexer_loop:
; loop through webx code, lex tokens
cmp byte [rdi], 0
je lexer_end
mov al, [rdi]
inc rdi
jmp lexer_loop
lexer_end:
ret

parser_loop:
; loop through webx tokens, build ast
cmp byte [rdi], 0
je parser_end
mov al, [rdi]
inc rdi
jmp parser_loop
parser_end:
ret

codegen_loop:
; loop through ast nodes, generate output
cmp byte [rdi], 0
je codegen_end
mov al, [rdi]
inc rdi
jmp codegen_loop
codegen_end:
ret