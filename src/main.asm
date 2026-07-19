; src/main.asm
section .text
global _start

; Entry point: compile the input file
_start:
    ; Check the argc (argument count) to ensure we have the required number of arguments
    mov rdi, 1         ; file descriptor for stdout
    mov rsi, msg_hello ; message to print
    mov rdx, msg_len   ; message length
    mov rax, 1         ; sys_write
    syscall

    ; Load the input file into memory
    mov rdi, argc      ; file descriptor for argument 1 (input file)
    mov rsi, input     ; buffer to store the file contents
    mov rdx, input_len ; buffer size
    mov rax, 0         ; sys_read
    syscall

    ; Parse the input file
    call lexer.asm

    ; Generate assembly code from the AST
    call codegen.asm

    ; Assemble the generated code into a binary
    mov rdi, output.asm ; input file for nasm
    mov rsi, output     ; output file
    mov rdx, output_len ; output file size
    mov rax, 1          ; sys_open
    syscall
    mov rdi, output_fd   ; file descriptor for output.asm
    mov rsi, output_bin  ; binary file
    mov rdx, output_bin_len
    mov rax, 1           ; sys_write
    syscall

    ; Link the generated binary
    mov rdi, output_bin  ; input file for ld
    mov rsi, output_bin_len
    mov rdx, output     ; output file
    mov rax, 1          ; sys_open
    syscall
    mov rdi, output_fd   ; file descriptor for output
    mov rsi, output_len  ; output file size
    mov rdx, output_bin  ; input file for ld
    mov rax, 9          ; sys_execve
    syscall

section .data
    msg_hello db 'Compiling WebX...', 0
    msg_len equ $ - msg_hello
    argc dq 1         ; argument count
    input db 0, 0, 0, 0, 0, 0, 0, 0 ; input buffer
    input_len dq 1024  ; input buffer size
    output db 0, 0, 0, 0, 0, 0, 0, 0 ; output buffer
    output_len dq 1024  ; output buffer size
    output_bin db 0, 0, 0, 0, 0, 0, 0, 0 ; output binary buffer
    output_bin_len dq 1024  ; output binary buffer size
    output_fd dq 0       ; file descriptor for output
    output_bin_fd dq 0    ; file descriptor for output.bin

; Lexer.asm is called to parse the input file
extern lexer.asm

; Codegen.asm is called to generate assembly code from the AST
extern codegen.asm

; Output binary is generated in output_bin.asm
extern output_bin.asm