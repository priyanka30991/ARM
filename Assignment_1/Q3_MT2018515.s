     AREA     factorial, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	

	MOV R0, #0X125      ;R0 = 125 ODD NUMBER IN HEXADECIMAL
	;MOV R0, #0X124		;R0 = 124 EVEN NUMBER IN HEXADECIMAL
	AND R1, R0, #0X01  ;R1 = R0 & 01 , 01 IS IN HEXADECIMAL
                       ;IF R1=0 THEN THE NUMBER IS EVEN AND IF R1=1 THEN THE INPUT NUMBER IS ODD    
stop    B stop ; stop program
     ENDFUNC
     END 