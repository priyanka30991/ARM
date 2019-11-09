     ;GCD
	 
	 AREA     GCD, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	    MOV R0, #15      ; R0=15
		MOV R1, #3       ; R1=3
LOOP    CMP  R0,R1       ; LOOP WILL EXECUTE TILL R0 IS NOT EQUAL TO R1
		SUBGT R0,R0,R1   ; IF(A>B) SUBTRACT  A=A-B HERE A IS R0 AND B IS R1
		SUBLT R1,R1,R0   ; IF(A<B) SUBTRACT  B=B-A
		BNE LOOP      
stop    B stop ; stop program
     ENDFUNC
     END 
