; lib/webcore.asm - WebX standard web library
;
; Copyright (c) 2026, Samy Alderson
; Forked from KDX by Yug Merabtene (https://github.com/yugmerabtene/KDX)

section .text
align 16

; WebX standard library functions
;
; println
;
; Prints the string pointed to by the rsi register, followed by a newline.
; The rsi register must be loaded with the address of the string before calling.
; 
; Parameters:
;   rsi - address of the string to print
; 
; Returns:
;   None
;
println:
    ; Load the address of the string to print into rsi
    mov rsi, rsi
    
    ; Call the C printf function with the string as an argument
    ; We don't actually call a C function here, but this is what we want to do
    ; in Phase 2 (frontend generation).
    ; For now, we just print the string directly.
    mov rdi, rsi
    call printf
    
    ; Print a newline
    mov rdi, newline
    call printf
    
    ; Return
    ret

; newline
;
; Prints a newline character.
; 
; Parameters:
;   None
; 
; Returns:
;   None
;
newline:
    ; Load the address of the newline string into rsi
    mov rsi, newline_str
    
    ; Call the C printf function with the string as an argument
    ; We don't actually call a C function here, but this is what we want to do
    ; in Phase 2 (frontend generation).
    ; For now, we just print the string directly.
    mov rdi, rsi
    call printf
    
    ; Return
    ret

newline_str:
    db ' ', 10, 0

; exit
;
; Exits the program with the given status code.
; 
; Parameters:
;   rdi - status code to return
; 
; Returns:
;   None
;
exit:
    ; Call the C exit function with the status code
    ; We don't actually call a C function here, but this is what we want to do
    ; in Phase 2 (frontend generation).
    ; For now, we just return the status code directly.
    mov rdi, rdi
    call exit
    
    ; This line should never be reached
    hlt

section .data
align 16

newline db '`, 10, 0
printf db 'printf', 0
exit db 'exit', 0