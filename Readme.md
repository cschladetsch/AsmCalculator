# NASM Calculator

This project implements a simple calculator using NASM (Netwide Assembler) that evaluates basic arithmetic expressions. It's designed to run on WSL/Ubuntu environments.

## Sample

```bash
$ ./r
Enter an expression: 1+8*3
Result: 25
Enter an expression: 4*6-8
Result: 16
```


## Features

- Evaluates basic arithmetic expressions
- Supports operators: +, -, *, /
- Handles operator precedence correctly
- Outputs the result of the expression

## Prerequisites

- WSL/Ubuntu
- NASM assembler
- CMake (version 3.10 or higher)

## Project Structure

- `main.asm`: Main entry point of the program
- `eval.asm`: Contains the expression evaluation logic
- `utils.asm`: Utility functions for I/O and number conversion
- `CMakeLists.txt`: CMake configuration file
- `README.md`: This file

## Building the Project

1. Clone the repository:
   ```
   git clone https://github.com/cschladetsch/AsmCalculator.git
   cd AsmCalculator
   ```

2. Build the project:
   ```
   ./m
   ```
   This script removes any existing build directory, creates a new one, runs CMake, and builds the project.

## Running the Calculator

After building, you can run the calculator using:

```
./build/asm_calculator
```

Alternatively, you can use the provided `r` script to build and run in one step:

```
./r
```

## Usage Examples

When prompted, enter a mathematical expression. The calculator will evaluate it and output the result.

Example 1:
```
Enter an expression: 1+2
Result: 3
```

Example 2:
```
Enter an expression: 3*4+2
Result: 14
```

Example 3:
```
Enter an expression: 5+6*7-8/2
Result: 45
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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
