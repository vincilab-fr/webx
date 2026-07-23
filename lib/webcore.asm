section .text
global _start

_start:
    ; Initialize the data segment
    mov rsi, offset .data
    mov rdi, rsi
    call init_data

init_data:
    ; Initialize the heap
    mov rsi, offset .heap
    mov rdi, rsi
    call init_heap

init_heap:
    ; Initialize the stack
    mov rsi, offset .stack
    mov rdi, rsi
    call init_stack

init_stack:
    ; Initialize the program counter
    mov rsi, offset main
    mov rdi, rsi
    call init_pc

init_pc:
    ; Call the main function
    call main

main:
    ; Print a message to the console
    mov rsi, offset msg
    mov rdi, rsi
    call print_string

print_string:
    ; Write a string to stdout
    mov rsi, rdi
    mov rdi, 1
    mov rdx, 10
    mov rax, 1
    syscall
    ret

msg:
    db 'Hello, World!', 0xA, 0

section .data
    align 16
    resb 16

section .heap
    align 16
    resb 16

section .stack
    align 16
    resb 16

    global _end

_end:
    ; Exit the program
    mov rsi, 60
    mov rdi, 0
    mov rax, 1
    syscall