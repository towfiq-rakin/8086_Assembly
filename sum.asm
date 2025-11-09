; Write a program to display a ‘?’ read two decimal digits whose sum is less than 10; display them and their sum on the next line, with prompt message.
; Sample Execution: 
; ? 3 5
; The sum of 3 and 5 is: 8

.MODEL SMALL
.STACK 100H
.DATA
    M1 DB 0AH,0DH,"The sum of $"
    A DB " and $"
    B DB " is: $"
    S DB "? $"
    NUM1 DB ?
    NUM2 DB ?
.CODE

MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, S 
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
    
    MOV BL, AL
    ADD BL, '0'
    
    LEA DX, M1
    MOV AH, 9
    INT 21H
              
    MOV DL, NUM1
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    LEA DX, A
    MOV AH, 9
    INT 21H 
    
    MOV DL, NUM2
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    LEA DX, B
    MOV AH, 9
    INT 21H 
    
    MOV DL, BL
    MOV AH, 2
    INT 21H
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
