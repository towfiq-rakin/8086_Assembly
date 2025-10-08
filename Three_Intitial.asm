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
    F DB ?
    M DB ?
    L DB ?
.CODE

MAIN PROC
    MOV AX, @DATA       ; Laod Variable
    MOV DS, AX
    
    MOV AH, 9           ; Print input promt
    LEA DX, Promt
    INT 21H
    
    MOV AH, 1           ; First initial input
    INT 21H
    MOV F, AL
    
    MOV AH, 1           ; Middle intial input
    INT 21H
    MOV M, AL
    
    MOV AH, 1           ; Last initial input
    INT 21H
    MOV L, AL                        
       
    MOV AH, 9           
    LEA DX, endl        ; New Line
    INT 21H
    
    MOV AH, 2           
    MOV DL, F           ; First output 
    INT 21H  
             
             
    MOV AH, 9
    LEA DX, endl        ; newline
    INT 21H 
            
    MOV AH, 2
    MOV DL, M           ; Middle output
    INT 21H
        
    MOV AH, 9
    LEA DX, endl        ; newline
    INT 21H
         
    MOV AH, 2
    MOV DL, L           ; Last output
    INT 21H   
        
    MOV AH, 4CH         ; return 0
    INT 21H

MAIN ENDP
END MAIN
