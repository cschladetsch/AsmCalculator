section .data
    stack_overflow_msg db "Stack overflow", 10, 0
    stack_underflow_msg db "Stack underflow", 10, 0

section .text
    global print_string
    global int_to_string
    global parse_number
    global print_char
    global print_newline
    global push_value
    global pop_value
    global pop_two

    ; Declare extern variables defined in eval.asm
    extern eval_stack
    extern eval_stack_top

print_string:
    ; rsi: string to print
    test rsi, rsi
    jz .done

    mov rdx, -1
.count:
    inc rdx
    cmp byte [rsi + rdx], 0
    jne .count

    mov rax, 1
    mov rdi, 1
    syscall

.done:
    ret

int_to_string:
    ; rax: integer to convert
    ; rdi: buffer to store string
    push rdi
    mov rcx, 0
    mov rbx, 10
    test rax, rax
    jns .convert
    neg rax
    mov byte [rdi], '-'
    inc rdi

.convert:
    mov rdx, 0
    div rbx
    add dl, '0'
    push rdx
    inc rcx
    test rax, rax
    jnz .convert

.build_string:
    pop rax
    mov [rdi], al
    inc rdi
    loop .build_string

    mov byte [rdi], 0
    pop rdi
    ret

parse_number:
    push rsi
    xor rax, rax
    movzx rdx, byte [rsi]
    sub rdx, '0'
    add rax, rdx
    ret

push_value:
    mov rbx, [eval_stack_top]
    cmp rbx, eval_stack + 800
    jae .overflow@
    mov [rbx], rax
    add qword [eval_stack_top], 8
    ret

.overflow@:
    mov rdi, stack_overflow_msg
    call print_string
    mov rax, 60
    xor rdi, rdi
    syscall

pop_value:
    mov rbx, [eval_stack_top]
    cmp rbx, eval_stack
    jbe underflow
    sub rbx, 8
    mov rax, [rbx]
    mov [eval_stack_top], rbx
    ret

underflow:
    mov rdi, stack_underflow_msg
    call print_string
    mov rax, 60
    xor rdi, rdi
    syscall

pop_two:
    mov rbx, [eval_stack_top]
    cmp rbx, eval_stack
    jbe underflow
    sub rbx, 8
    mov rax, [rbx]
    sub rbx, 8
    mov rbx, [rbx]
    mov [eval_stack_top], rbx
    ret

print_char:
    push rdi
    mov rsi, rsp
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall
    pop rdi
    ret

print_newline:
    mov rdi, 10
    call print_char
    ret

