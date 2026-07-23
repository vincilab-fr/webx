section .text
align 16
global _start

section .data
align 16
stdout db 'stdout', 0
stderr db 'stderr', 0
buf db 'Error: ', 0
errcode dd 1

print_string:
    ; sys_write(1, buf, len(buf))
    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, 6
    syscall

    ret

print_error:
    ; sys_write(2, buf, len(buf))
    mov rax, 1
    mov rdi, 2
    mov rsi, buf
    mov rdx, 6
    syscall

    ret

start:
    ; sys_write(1, stdout, len(stdout))
    mov rax, 1
    mov rdi, 1
    mov rsi, stdout
    mov rdx, 6
    syscall

    ; sys_write(1, buf, len(buf))
    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, 6
    syscall

    ; sys_exit(0)
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
align 16
stdout db 'stdout', 0
stderr db 'stderr', 0
buf db 'Hello, World!', 0
errcode dd 0

print_string:
    ; sys_write(1, buf, len(buf))
    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, 13
    syscall

    ret

print_error:
    ; sys_write(2, buf, len(buf))
    mov rax, 1
    mov rdi, 2
    mov rsi, buf
    mov rdx, 13
    syscall

    ret

start:
    ; sys_write(1, stdout, len(stdout))
    mov rax, 1
    mov rdi, 1
    mov rsi, stdout
    mov rdx, 6
    syscall

    ; sys_write(1, buf, len(buf))
    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, 13
    syscall

    ; sys_exit(0)
    mov rax, 60
    xor rdi, rdi
    syscall

extern exit
extern puts

section .data
align 16
str db 'Hello, World!', 0

extern _start

_start:
    ; call puts
    call puts
    ; call exit
    call exit
    ; xor rdi, rdi
    ; call exit
    ; xor rdi, rdi
    ; call exit

extern printf
extern exit

section .data
align 16
format db 'Hello, World!', 10, 0

extern _start

_start:
    ; call printf
    call printf
    ; xor rdi, rdi
    ; call exit

extern printf
extern exit

section .data
align 16
format db 'Hello, World!', 10, 0

extern _start

_start:
    ; call printf
    call printf
    ; xor rdi, rdi
    ; call exit

extern printf
extern exit

section .data
align 16
format db 'Hello, World!', 10, 0

extern _start

_start:
    ; call printf
    call printf
    ; xor rdi, rdi
    ; call exit