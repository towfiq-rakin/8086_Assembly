; Write a program to read two characters. Print them in next line in Alphabetic order

.MODEL SMALL
.STACK 100H

.DATA
    PROMPT  DB  'Enter two characters: $'
    OUTPUT  DB  0DH,0AH,'In alphabetic order: $'
    CHAR1    DB  ?
    CHAR2    DB  ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, PROMPT
    MOV AH, 9
    INT 21H

    MOV AH, 1
    INT 21H 
    MOV CHAR1, AL

    MOV AH, 1
    INT 21H

    MOV AH, 1
    INT 21H
    MOV CHAR2, AL

    MOV AL, CHAR1
    CMP AL, CHAR2
    JBE PRINT_FIRST 
    
    LEA DX, OUTPUT
    MOV AH, 9
    INT 21H

PRINT_SECOND:
    MOV DL, CHAR2
    MOV AH, 2
    INT 21H
    
    MOV DL, CHAR1
    INT 21H
    
    MOV AH, 4CH
    INT 21H

PRINT_FIRST:
    MOV DL, CHAR1
    MOV AH, 2
    INT 21H
    
    MOV DL, CHAR2
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
