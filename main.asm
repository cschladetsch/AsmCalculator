section .data
    buffer_size equ 1024
    prompt db "Enter an expression: ", 0
    prompt_len equ $ - prompt
    newline db 10, 0
    space db " ", 0

section .bss
    input_buffer resb buffer_size
    output_buffer resb buffer_size
    stack resb 100
    stack_top resb 8

section .text
    global _start

_start:
    ; Print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; Read input
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, buffer_size
    syscall

    ; Parse input
    mov rsi, input_buffer
    mov rdi, output_buffer
    call parse_expression

    ; Print result
    mov rsi, output_buffer
    call print_string

    ; Print newline
    mov rsi, newline
    call print_string

    ; Exit program
    mov rax, 60
    xor rdi, rdi
    syscall

parse_expression:
    ; rsi: input buffer
    ; rdi: output buffer
    mov r8, stack        ; r8 is our stack pointer
    .loop:
        movzx eax, byte [rsi]
        test al, al
        jz .done
        
        cmp al, ' '
        je .next_char
        
        cmp al, '0'
        jl .check_operator
        cmp al, '9'
        jg .check_operator
        
        ; It's a number, copy it to output
        mov [rdi], al
        inc rdi
        mov byte [rdi], ' '
        inc rdi
        jmp .next_char
        
    .check_operator:
        cmp al, '+'
        je .handle_operator
        cmp al, '-'
        je .handle_operator
        cmp al, '*'
        je .handle_operator
        cmp al, '/'
        je .handle_operator
        jmp .next_char
        
    .handle_operator:
        ; While stack not empty and top of stack has higher precedence
        .operator_loop:
            cmp r8, stack
            je .push_operator
            dec r8
            mov cl, [r8]
            call compare_precedence
            jl .pop_operator
            inc r8
            jmp .push_operator
            
        .pop_operator:
            mov [rdi], cl
            inc rdi
            mov byte [rdi], ' '
            inc rdi
            jmp .operator_loop
            
        .push_operator:
            mov [r8], al
            inc r8
            
    .next_char:
        inc rsi
        jmp .loop
        
    .done:
        ; Pop remaining operators from stack
        .pop_remaining:
            cmp r8, stack
            je .exit
            dec r8
            mov al, [r8]
            mov [rdi], al
            inc rdi
            mov byte [rdi], ' '
            inc rdi
            jmp .pop_remaining
            
    .exit:
        mov byte [rdi], 0  ; Null-terminate the output string
        ret

compare_precedence:
    ; al: current operator
    ; cl: stack operator
    ; Returns: al < cl (lower precedence) if cf=1
    cmp cl, '*'
    je .high_precedence
    cmp cl, '/'
    je .high_precedence
    cmp al, '*'
    je .higher_precedence
    cmp al, '/'
    je .higher_precedence
    ; Both are + or -, equal precedence
    clc
    ret
.high_precedence:
    cmp al, '*'
    je .equal_precedence
    cmp al, '/'
    je .equal_precedence
    ; cl is * or /, al is + or -, lower precedence
    stc
    ret
.higher_precedence:
    ; al is * or /, cl is + or -, higher precedence
    clc
    ret
.equal_precedence:
    ; Both are * or /, equal precedence
    clc
    ret

print_string:
    ; rsi: string to print
    mov rdx, -1
.count:
    inc rdx
    cmp byte [rsi + rdx], 0
    jne .count
    
    mov rax, 1
    mov rdi, 1
    syscall
    ret
