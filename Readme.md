# NASM RPN Parser

This project implements a simple mathematical expression parser using NASM (Netwide Assembler) that converts infix notation to Reverse Polish Notation (RPN). It's designed to run on WSL/Ubuntu environments.

## Features

- Parses basic arithmetic expressions
- Supports operators: +, -, *, /
- Handles operator precedence correctly
- Outputs the expression in Reverse Polish Notation

## Prerequisites

- WSL/Ubuntu
- NASM assembler
- CMake (version 3.10 or higher)

## Building the Project

1. Clone the repository:
   ```
   git clone https://github.com/cschladetsch/AsmRpn.git
   cd AsmRpn
   ```

2. Build the project:
   ```
   ./m
   ```
   This script removes any existing build directory, creates a new one, runs CMake, and builds the project.

## Running the Parser

After building, you can run the parser using:

```
./build/nasm_parser
```

Alternatively, you can use the provided `r` script to build and run in one step:

```
./r
```

## Usage Examples

When prompted, enter a mathematical expression. The parser will output the equivalent expression in RPN.

Example 1:
```
Enter an expression: 1+2
Output: 1 2 +
```

Example 2:
```
Enter an expression: 3*4+2
Output: 3 4 * 2 +
```

Example 3:
```
Enter an expression: 5+6*7-8/2
Output: 5 6 7 * + 8 2 / -
```

## Limitations

- Currently only supports single-digit numbers
- Does not support parentheses
- Limited to basic arithmetic operators (+, -, *, /)

## Future Enhancements

- Support for multi-digit numbers
- Parentheses handling
- Additional operators (e.g., exponentiation, modulus)
- Floating-point number support
- Variable support
- Mathematical function support (e.g., sin, cos, log)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
