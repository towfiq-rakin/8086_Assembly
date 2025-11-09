.MODEL SMALL
.STACK 100H

.DATA
    PROMPT  DB  'Enter three decimal digits: $'
    MSG     DB  ' is the largest$'
    NUM1    DB  ?
    NUM2    DB  ?
    NUM3    DB  ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, PROMPT
    MOV AH, 09H
    INT 21H

    MOV AH, 1
    INT 21H
    SUB AL, '0'
    MOV NUM1, AL

    INT 21H

    INT 21H
    SUB AL, '0'
    MOV NUM2, AL

    INT 21H

    INT 21H
    SUB AL, '0'
    MOV NUM3, AL

    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    MOV AL, NUM1
    
    CMP AL, NUM2
    JGE CHECK_NUM3
    MOV AL, NUM2
    
CHECK_NUM3:
    CMP AL, NUM3
    JGE DISPLAY
    MOV AL, NUM3

DISPLAY:
    ADD AL, '0'
    MOV DL, AL
    
    MOV AH, 2
    INT 21H

    LEA DX, MSG
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
