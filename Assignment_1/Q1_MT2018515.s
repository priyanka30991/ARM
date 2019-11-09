     ;fibonacci_series
	 
	 AREA     fibonacci_series, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
	
	  MOV R0,#0     ;Initial number  A = 0 
      MOV R1,#1     ;Initial number  B = 1
      MOV R2,#0     ;C=A+B  HERE, R0 IS A, R1 IS B, R2 IS C 
	  MOV R3,#50    ;Upto 50 (0 TO 50) -- REQ 
      ADD R2,R0,R1  ;R3 = R0+R1 -- VAL
LP    CMP R2,R3     ;if(val > req) 
      BLE LOOP     ;if less goto LOOP 
     B stop        ;Else goto end  
LOOP  MOV R0,R1      ;t1=t0; 
      MOV R1,R2     ;t0=val 
      ADD R2,R0,R1  ;val = t0 + t1 
     B LP        ;LOOP until val >= req 
stop    B stop ; stop program
     ENDFUNC
     END 
