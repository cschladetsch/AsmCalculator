extern parse_number
extern print_string
extern int_to_string
extern print_newline
extern push_value
extern pop_two
extern print_char
extern pop_value  ; Declare pop_value as extern

section .data
    stack_overflow_msg db "Stack overflow", 10, 0
    stack_underflow_msg db "Stack underflow", 10, 0
    debug_push db "Pushed: ", 0
    debug_pop db "Popped: ", 0
    debug_op db "Operation: ", 0
    debug_char db "Current char: ", 0
    debug_parse db "Parsed number: ", 0
    debug_done db "Calculation done", 10, 0

section .bss
    eval_stack resq 100
    eval_stack_top resq 1
    debug_buffer resb 20

section .text
    global evaluate_expression

evaluate_expression:
    ; rsi: input buffer
    mov qword [eval_stack_top], eval_stack
.loop@:
    movzx eax, byte [rsi]
    
    ; Debug: print current character
    push rax
    mov rdi, debug_char
    call print_string
    pop rax
    push rax
    mov rdi, rsp
    call print_string
    call print_newline
    pop rax
    
    test al, al
    jz .done@   ; Check for the end of the string and exit loop
    
    cmp al, ' '
    je .next_char@
    
    cmp al, '0'
    jl .check_operator@
    cmp al, '9'
    jg .check_operator@
    
    ; It's a number, parse it
    call parse_number
    call push_value
    jmp .next_char@
    
.check_operator@:
    cmp al, '+'
    je .do_add@
    cmp al, '-'
    je .do_subtract@
    cmp al, '*'
    je .do_multiply@
    cmp al, '/'
    je .do_divide@
    jmp .next_char@
    
.do_add@:
    mov rdi, debug_op
    call print_string
    mov rdi, '+'
    call print_char
    call print_newline
    call pop_two
    add rax, rbx
    jmp .push_result@

.do_subtract@:
    mov rdi, debug_op
    call print_string
    mov rdi, '-'
    call print_char
    call print_newline
    call pop_two
    sub rbx, rax
    mov rax, rbx
    jmp .push_result@

.do_multiply@:
    mov rdi, debug_op
    call print_string
    mov rdi, '*'
    call print_char
    call print_newline
    call pop_two
    imul rax, rbx
    jmp .push_result@

.do_divide@:
    mov rdi, debug_op
    call print_string
    mov rdi, '/'
    call print_char
    call print_newline
    call pop_two
    xchg rax, rbx
    cqo
    idiv rbx
    jmp .push_result@

.push_result@:
    call push_value

.next_char@:
    inc rsi
    jmp .loop@

.done@:
    ; Exit loop and print done message
    mov rdi, debug_done
    call print_string
    call pop_value  ; Return the top value
    ret

