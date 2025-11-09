; Sum of two digit where result is larger than 10

.MODEL SMALL
.STACK 100H
.DATA
    PROMT DB "Enter Two decimal digits: $"
    OUTPUT DB 0DH,0AH, "The sum is: $"
    NUM1 DB ?
    NUM2 DB ?
.CODE

MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, PROMT
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
    
    MOV AL, 0
    ADD AL, NUM1
    ADD AL, NUM2
    
    MOV AH, 0
    AAA
    MOV BX, AX
    
    ADD BH, '0'
    ADD BL, '0'
    
    LEA DX, OUTPUT
    MOV AH, 9
    INT 21H
             
    MOV DL, BH
    MOV AH, 2
    INT 21H 
    
    MOV DL, BL
    MOV AH, 2
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
