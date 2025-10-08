; Write a program to read to read five characters from keyboard and display them into the next line in reverse order. 
; Simple Execution:
; Enter 5 Characters: ABCDE
; REVERSE Order: EDCBA


.MODEL SMALL
.STACK 100H
.DATA
    input DB "Enter 5 Character: $" 
    output DB 0AH,0DH,"Reverse Order: $"

.CODE

MAIN PROC 
    MOV BX, 0001H
    MOV CX, 5
    
    MOV AX, @DATA       ; Laod Variable
    MOV DS, AX
    
    MOV AH, 9           ; Print input promt
    LEA DX, input
    INT 21H
    
    ONE:
        MOV AH, 1
        INT 21H
        MOV [BX], AL    ; Loop to take 5 input
        INC BX
    LOOP ONE                        
             
    MOV CX, 5 
    
    MOV AH, 9
    LEA DX, output      ; Output Promt
    INT 21H
    
    
    TWO:        
        DEC BX         
        MOV AH, 2       ; Loop for output
        MOV DL, [BX]
        INT 21H

    LOOP TWO     
        
    MOV AH, 4CH         ; return 0
    INT 21H

MAIN ENDP
END MAIN
    
    
    
