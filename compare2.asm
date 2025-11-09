; Write a program to read two decimal digits. Find the larger number with message.

.MODEL SMALL
.STACK 100H

.DATA
    PROMPT  DB  'Enter two number: $'
    OUTPUT  DB  ' is larger$'
    ENDL    DB 0DH,0AH, "$"
    NUM1    DB  ?
    NUM2    DB  ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, PROMPT
    MOV AH, 9
    INT 21H

    MOV AH, 1
    INT 21H
    SUB AL, '0' 
    MOV NUM1, AL

    MOV AH, 1
    INT 21H

    MOV AH, 1
    INT 21H
    SUB AL, '0'
    MOV NUM2, AL

    LEA DX, ENDL
    MOV AH, 9
    INT 21H

    MOV AL, NUM1
    CMP AL, NUM2
    JGE PRINT_FIRST 

PRINT_SECOND:
    MOV AL, NUM2
    JMP DISPLAY    

PRINT_FIRST:
    MOV AL, NUM1

DISPLAY:
    ADD AL, '0'
    MOV DL, AL
    
    MOV AH, 2
    INT 21H

    LEA DX, OUTPUT
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
