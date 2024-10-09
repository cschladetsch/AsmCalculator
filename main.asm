extern evaluate_expression
extern print_string
extern int_to_string
extern print_newline

section .data
    prompt db "Enter an expression: ", 0
    prompt_len equ $ - prompt
    result_msg db "Result: ", 0
    result_msg_len equ $ - result_msg
    newline db 10, 0

section .bss
    input_buffer resb 1024
    number_buffer resb 20

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
    mov rdx, 1024
    syscall

    ; Evaluate expression
    mov rsi, input_buffer
    call evaluate_expression

    ; Print result message
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, result_msg_len
    syscall

    ; Convert result to string and print
    mov rdi, number_buffer
    call int_to_string
    mov rsi, number_buffer
    call print_string

    ; Print newline
    call print_newline  ; Call the print_newline function

    ; Exit program
    mov rax, 60
    xor rdi, rdi
    syscall

