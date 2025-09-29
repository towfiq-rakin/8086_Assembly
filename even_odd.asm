; Even Odd

MOV AL, 03H
MOV BL, 04H

TEST AL, 01H        ; Check if the LSB of AL is 1 or not, if 1, it's ODD ; Al & 01
JZ AL_EVEN          ; if Zero Flag = 1
JNZ AL_ODD          ; if Zero Flag = 0

AL_EVEN:
    MOV DL, AL
    JMP GO
AL_ODD:
    MOV DH, AL
    
GO:
TEST BL, 01H
JZ BL_EVEN
JNZ BL_ODD

BL_EVEN:
    MOV DL, BL
    HLT
BL_ODD:
    MOV DH, BL
