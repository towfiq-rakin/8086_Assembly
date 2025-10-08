; Write a program to prompt the user, and read first, middle and read last initials of a person’s name, and display them down the left margin. 
; Simple execution:
; Enter Three Initials: MMH
; M
; M
; H


.MODEL SMALL
.STACK 100H
.DATA
    Promt DB "Enter Three Initials: $"
    endl DB 0DH,0AH, "$"
.CODE

MAIN PROC 
    MOV BX, 0001H
    MOV CX, 3
    
    MOV AX, @DATA       ; Laod Variable
    MOV DS, AX
    
    MOV AH, 9           ; Print input promt
    LEA DX, Promt
    INT 21H
    
    ONE:
        MOV AH, 1
        INT 21H
        MOV [BX], AL    ; Loop to take 3 input
        INC BX
    LOOP ONE                        
             
    MOV CX, 3
    SUB BX, 3  
    
    TWO:
        MOV AH, 9
        LEA DX, endl
        INT 21H
                         
        MOV AH, 2       ; Loop for output
        MOV DL, [BX]
        INT 21H
        INC BX
    LOOP TWO     
        
    MOV AH, 4CH         ; return 0
    INT 21H

MAIN ENDP
END MAIN
    
    
    
