; ODD Series Sum, 1+3+5+7...+15

MOV AX, 0
MOV CX, 1

SERIES:
    ADD AX, CX
    ADD CX, 2       ; Increment CX by 2
    CMP CX, 15      ; Compare CX with 15 ; CX - 15
    JBE SERIES      ; CX below or Equal 15 ; CX <= 15
HLT 
