# Two-Function-Calculator
## Input Unit (IU)
This module takes user inputs from the keypad (row and column values) and processes them into usable signals for the calculator. It ensures the entered data is ready for further processing.

## Arithmetic Unit (AU8)
This module performs arithmetic operations, such as addition and subtraction, using inputs A and B. It generates results (Rout) along with flags like overflow (ovr), zero, negative (neg), and carry out (cout) to indicate specific conditions of the result.

## Control Unit (CU)
This module manages the flow of operations within the calculator. Based on inputs and current states, it sends control signals to coordinate data handling and operations between units.

## Output Unit (OU)
This module converts the calculator's results (Rout and other indicators) into a displayable format on seven-segment displays (HEX0 to HEX3), providing the final output for the user.
