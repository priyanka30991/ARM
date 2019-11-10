     AREA     exp_series, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	

	
	VLDR.F32 S1, =40		; X=5
	MOV 	 R1, #35	; LIMIT 15 ITERATIONS NO. OF TERM IN e^x expansion
	MOV		 R2, #1		; initial COUNT value = 1
	MOV		 R3, #1		; incrementing COUNT by 1 till it reahes 10
	VMOV.F32 S2, #1		; i = 1 
	VMOV.F32 S3, #1		; incrementing i BY 1
	VMOV.F32 S4, #1		; temp1 = 1
	VMOV.F32 S5, #1		; temp2 = 1
	VMOV.F32 S6, #1		; SUM = 1
	
LOOP 
	CMP R1,R2			; COMPARE COUNT VALUE & LIMIT VALUE
	BLT stop			; LOOP CONT TILL COUNT LESS THEN THE LIMIT
	
	VDIV.F32 S4,S1,S2		; temp1 = X/i
	VMUL.F32 S5,S5,S4 		; temp2 = temp2*temp1
	VADD.F32 S6,S6,S5 		; SUM = SUM+temp2
	VADD.F32 S2,S2,S3		; i = i+1
	ADD      R2,R2,R3		; COUNT = COUNT+1
	B LOOP
	
stop    B stop ; stop program
     ENDFUNC
     END 