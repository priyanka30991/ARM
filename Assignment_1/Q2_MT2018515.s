;largest_number

	 AREA     largest_number, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
		MOV R0, #6  ; RO = 6
		MOV R1, #2  ; R1 = 2
		MOV R2, #4 ; R2 = 4
		CMP R0,R1
			IT HI   ; R0>R1
			MOVHI R1, R0  ; MOVE THE VALUE OF R1 TO R0
		CMP R1,R2
			IT HI
			MOVHI R2,R1  ; MOVE THE VALUE OF R2 TO R1
		MOV R3,R2  ; RESULT LARGEST NUMBER MOVE TO R3

stop    B stop ; stop program
     ENDFUNC
     END 
