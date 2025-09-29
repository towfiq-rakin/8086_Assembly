; Compare Two Number

MOV AL, 29H
MOV CL, 41H

CMP AL, CL          ; AL - BL
JL AL_Smaller       ; Jump if AL is Less ; SF > OF
JG CL_Smaller       ; Jump if AL is Greater

AL_Smaller:
    MOV BL, AL
    MOV BH, CL
HLT

CL_Smaller:
    MOV BL, CL
    MOV BH, AL
HLT    
