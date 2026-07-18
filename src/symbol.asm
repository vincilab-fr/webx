; src/symbol.asm - Symbol table management for WebX compiler
; Original KDX code by Yug Merabtene, adapted for WebX by Samy Alderson

section .data
; Symbol table structure:
;   - symbol_name (null-terminated string)
;   - symbol_type (byte: 0 = undefined, 1 = variable, 2 = function)
;   - symbol_scope (byte: 0 = global, 1 = local)
;   - symbol_offset (dword: memory offset)

symbol_table times 1024 db 0

section .bss
symbol_table_size resd 1
symbol_table_capacity resd 1

section .text
; Initialize symbol table
global init_symbol_table
init_symbol_table:
    ; Set initial capacity and size
    mov dword [symbol_table_capacity], 1024
    mov dword [symbol_table_size], 0
    ret

; Add symbol to table
global add_symbol
add_symbol:
    ; Check if symbol already exists
    mov ecx, [symbol_table_size]
    cmp ecx, [symbol_table_capacity]
    jge .capacity_error

    ; Find empty slot in table
    mov edx, symbol_table
.add_symbol_loop:
    cmp byte [edx], 0
    je .found_slot
    add edx, 17 ; sizeof(symbol) = 17 bytes (name + type + scope + offset)
    loop .add_symbol_loop

    ; If no empty slot found, increase capacity
    mov ecx, [symbol_table_capacity]
    add ecx, 1024
    mov [symbol_table_capacity], ecx
    mov edx, symbol_table
    add edx, [symbol_table_size]
    jmp .add_symbol_loop

.found_slot:
    ; Copy symbol name
    mov esi, [esp + 4] ; symbol_name
    mov edi, edx
    cld
    mov ecx, 16 ; max symbol name length
    rep movsb

    ; Set symbol type and scope
    mov byte [edx + 16], [esp + 8] ; symbol_type
    mov byte [edx + 17], [esp + 9] ; symbol_scope

    ; Set symbol offset (not implemented yet, this was tricky)
    ; not proud of this but it works for now
    mov dword [edx + 18], 0

    ; Increment symbol table size
    inc dword [symbol_table_size]
    ret

.capacity_error:
    ; Handle capacity error (not implemented yet)
    ret

; Get symbol from table
global get_symbol
get_symbol:
    ; Find symbol in table
    mov ecx, [symbol_table_size]
    mov edx, symbol_table
.get_symbol_loop:
    cmp byte [edx], 0
    je .not_found
    mov esi, [esp + 4] ; symbol_name
    mov edi, edx
    cld
    mov ecx, 16 ; max symbol name length
    repe cmpsb
    je .found
    add edx, 17 ; sizeof(symbol) = 17 bytes (name + type + scope + offset)
    loop .get_symbol_loop

.found:
    ; Return symbol type and scope
    movzx eax, byte [edx + 16]
    movzx ebx, byte [edx + 17]
    ret

.not_found:
    ; Handle not found error (not implemented yet)
    ret