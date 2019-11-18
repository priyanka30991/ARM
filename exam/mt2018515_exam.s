     AREA     circle, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
  	 IMPORT printMsg2p
	 IMPORT printMsg4p
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
 
		
		VLDR.F S0,= 0 			; angle in radian
		VLDR.F S1,= 20  		; RADIUS AND CENTER COORDINATES 		
		VLDR.F S15,= 0.1 		; angle incremented by 0.1
		VLDR.F S16,= 6.3 		; last value 360 degree in radian

MAINLOOP
		LDR R3,= 20 	        ; 20 iterations 
		VMOV.F S4,S0  			; angle 
		VLDR.F S5,= 1
		LDR R6,= 0 		
		VLDR.F S6,= 1
		VLDR.F S7,= 1
		VLDR.F S10,= 1 			
		VMOV.F S3,R3 			; general purpose registe into floating point register
		VCVT.F32.U32 S3,S3
		
		LDR R4,= 0 
		LDR R10,= 0  
		LDR R5,= 0  
		LDR R0,= 1 
		VLDR.F S9,= 0 			; result
		
NEXTITR
		LDR R12,= 0 			; R12 = 0 for COS 
		CMP R10,R3
		BNE COSFUN
		VMOV.F S11,S9 			; FINAL COS(X) RESULT
		LDR R12,= 1 			; R12 = 1 for SINE 
		LDR R4,= 0 
		LDR R10,= 0   
		BEQ SINEFUN
		
		
NEXTITRSINE
		
		CMP R10,R3 
		BNE SINEFUN
		VMOV.F S12,S9 			; FINAL SIN(X) RESULT
		VMUL.F S13,S12,S1 		; sin@ = Y 
		VMUL.F S14,S11,S1 		; cos@ = X 
		VADD.F S17,S13,S1 		; Y coordinate
		VADD.F S18,S14,S1 		; X coordinate
		
		
		VCVT.U32.F32 S17,S17
		VMOV R0,S17 ; 
		
		VCVT.U32.F32 S18,S18
		VMOV R1,S18 ;
		BL printMsg2p
		
		; angle incremented 
		VADD.F S0,S15
		VCMP.F S0,S16
		VMRS APSR_nzcv,FPSCR
		BLT MAINLOOP
		B stop
		
COSFUN
		B EVENODD 				; TO DETECT n IS EVEN/ODD
		
; SIN(X) IS FOUND OUT IN THIS LOOP
SINEFUN
		AND R7,R4,#1
		ADD R4,R4,R4 
		ADD R4,#1
		CMP R4,#1
		LDR R5,= 0  
		LDR R6,= 0 
		VLDR.F S5,= 1
		BEQ FIRSTITRSINE
		BNE POW1

; SERIES IS IMPLEMENTED ITERATIVELY HERE		
LOOP 
		VDIV.F S8,S0,S5
		CMP R7,R0
		ITE LT
		VADDLT.F S9,S9,S8
		VSUBGE.F S9,S9,S8 		; COS(X) RESULT IS STORED HERE
		ADD R10,#1
		MOV R4,R10
		VLDR.F S5,= 1
		VMOV.F S0,S4
		LDR R6,= 0 ;
		VLDR.F S6,= 1
		LDR R5,= 0 ; 
		CMP R12,#0
		BEQ NEXTITRSINE
		BNE NEXTITR 
		
; THIS LOOP IS USED TO FIND OUT X^2n OR X^(2n+1)
COSPOW 
		ADD R4,R4,R4
		CMP R4,#0
		BEQ FIRSTITR
		BNE POW1
POW1		

		SUB R11,R4,#1
		VMUL.F S0,S0,S4 		; S0 HAVE POWER VALUE
		ADD R5,#1
		CMP R5,R11
		BNE POW1
		BEQ FACT
		
FIRSTITR
		VMOV.F S0,S10
		VMOV.F S5,S10
		B LOOP
		
FIRSTITRSINE

		VMOV.F S0,S4
		VMOV.F S5,S4
		VMOV.F S9,S4
		ADD R10,#1
		mov r4,r10
		B NEXTITRSINE

;  FACTORIAL OF A NUMBER
FACT 
		CMP R4,#0
		BEQ FIRSTITR
		VMUL.F S5,S5,S6 		; S5 FACTORIAL RESULT
		ADD R6,#1
		VMOV.F S6,R6
		VCVT.F32.U32 S6,S6
		VADD.F S6,S6,S10
		CMP R6,R4
		BNE FACT
		BEQ LOOP
		
EVENODD
		AND R7,R4,#0x00000001
		B COSPOW

VGADISPLAY	
		
stop    B stop ; stop program
        ENDFUNC
        END 		
		