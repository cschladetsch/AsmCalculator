echo AsmCalc loaded.

# Project-specific settings
set disassembly-flavor intel
set print asm-demangle on

# Break at the start of evaluate_expression
break evaluate_expression

# Define a command to run until evaluate_expression
define rev
  delete
  break evaluate_expression
  continue
end

# Define a command to examine the input string
define xi
  x/s $rsi
end

# Automate actions when breaking at evaluate_expression
commands
  silent
  print "Entering evaluate_expression"
  info registers
  disas
  xinput
  echo \n
end

# Start the program and break at evaluate_expression
file build/asm_calculator
start
rev

