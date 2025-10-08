.MODEL SMALL
.STACK 100H
.DATA
    input DB "Enter a Character: $" 
    output DB 0AH,0DH,"Output: $"

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
             
    MOV AH, 9
    LEA DX, input
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV BL, AL
        
    MOV AH, 9
    LEA DX, output
    INT 21H
    
    MOV CX, 10
    FOR:
        MOV AH, 2
        MOV DL, BL
        INT 21H
        INC BL        
    LOOP FOR
    
    MOV AH, 4CH       
    INT 21H

MAIN ENDP
END MAIN
    
    
    
