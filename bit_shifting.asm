; SHIFT value to left and observe CF

MOV DH, 2AH
SAL DH, 1       ; 1 Bit left shift, CF = 0 

MOV DH, 2AH
SAL DH, 3       ; 3 Bit left shift, CF = 1

MOV CL, 03
SAL CL, 1       ; 1 Bit left shift, CF = 0 

MOV CL, 03
SAL CL, 7       ; 7 Bit left shift, CF = 1
