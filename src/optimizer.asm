; src/optimizer.asm

section .text
    global optimizer

optimizer:
    ; optimizer function signature
    ; void optimizer(void)

    ; Check for dead code elimination
    ; If a basic block has no uses, it's dead and can be removed
    ; This is a very basic implementation and can be improved
    mov rsi, [rsp + 8] ; Get the AST node
    mov rdi, [rsi + 16] ; Get the basic block
    test rdi, rdi
    jz .skip_block

    ; Check if the basic block has any uses
    mov rcx, [rdi + 32] ; Get the first use
    test rcx, rcx
    jz .block_is_dead

.skip_block:
    ; If the basic block is not dead, skip it
    jmp .next_block

.block_is_dead:
    ; If the basic block is dead, remove it
    mov rsi, [rsp + 8] ; Get the AST node
    mov rdi, [rsi + 16] ; Get the basic block
    mov rsi, [rdi + 24] ; Get the previous block
    mov [rsi + 32], rdi ; Update the previous block's next block
    mov rsi, [rdi + 40] ; Get the next block
    test rsi, rsi
    jz .remove_block
    mov [rsi + 32], rdi ; Update the next block's previous block
.remove_block:
    ; Remove the dead basic block
    mov rsi, [rdi + 48] ; Get the block's data
    mov [rdi + 48], 0 ; Clear the block's data
    mov [rdi + 16], 0 ; Clear the basic block pointer

.next_block:
    ; Move to the next basic block
    mov rsi, [rsp + 8] ; Get the AST node
    mov rdi, [rsi + 16] ; Get the current block
    mov rsi, [rdi + 40] ; Get the next block
    test rsi, rsi
    jz .optimizer_done
    mov rdi, rsi
    jmp .optimizer

.optimizer_done:
    ret

section .data
    optimizer_done_msg db 'Optimizer done', 0
    optimizer_done_len equ $ - optimizer_done_msg

global _start

_start:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rsp], optimizer_done_msg
    call optimizer
    mov rsi, optimizer_done_msg
    mov rdi, 1
    mov rax, 1
    syscall
    mov rsp, rbp
    pop rbp
    ret