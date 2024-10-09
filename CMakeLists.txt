cmake_minimum_required(VERSION 3.10)
project(AsmCalculator ASM_NASM)

enable_language(ASM_NASM)

if(CMAKE_ASM_NASM_COMPILER_LOADED)
    set(CAN_USE_ASSEMBLER TRUE)
endif(CMAKE_ASM_NASM_COMPILER_LOADED)

set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -g -F dwarf -f elf64")
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")

add_executable(asm_calculator 
    main.asm
    eval.asm
    utils.asm
)

set_target_properties(asm_calculator PROPERTIES LINK_FLAGS "-no-pie")

