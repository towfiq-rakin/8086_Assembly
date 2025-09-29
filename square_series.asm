; Square Series Sum of 1^2 + 2^2 + 3^2 + 4^2

MOV AX, 1
MOV CX, 1           ; CX is counter

SERIES:
    MOV AL, CL      ; AL = CL
    MUL CL          ; AX = AL * CL
    ADD BX, AX      ; Store into BX
    INC CX          ; CX = CX + 1
    CMP CX, 4       ; Compare CX with 4, CX-4
    JBE SERIES      ; Jump if CX below or equal 4
    
MOV AX, BX          ; AX will hold the final result
HLT 
