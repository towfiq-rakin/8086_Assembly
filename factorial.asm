; Factorial of 7

MOV AX, 1
MOV CX, 7

FACTORIAL:
    MUL CX              ; AX = AL * CL ; Multiply AL wiht CL and store it in AX
    LOOP FACTORIAL      ; CX != 0 and CX-- ; By defualt LOOP Decrement CX
