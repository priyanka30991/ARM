     AREA     sigmoid, CODE, READONLY
     EXPORT __main
     
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
				
			VLDR.F32 S11,= -5.2 		; z
		    VLDR.F32 S12,= 0.2			; Increment value
		    VLDR.F32 S13,= 5
			
LP		    VCMP.F32 S11,S13
		    VMRS.F32 APSR_nzcv,FPSCR; 
			VADD.F32 S11,S11,S12;
		    BLE SIGMOID
		    B LP
			 	     	 
SIGMOID			VMOV.F32 S1, S11		; x:Number to find e^x
				VMOV.F32 S2, #30		; Number of iterations for e^x expansion
				VMOV.F32 S3, #1			; count
				VMOV.F32 S4, #1			; temp variable
				VMOV.F32 S5, #1			; result initialized to 1
				VMOV.F32 S7, #1			; register to hold 1
				VMOV.F32 S10,#1

Loop 			VCMP.F32 S2, S3			; Comparison done for excuting taylor series expansion of e^x for s2 number of terms
				VMRS.F32 APSR_nzcv,FPSCR; to copy fpscr to apsr
				BLT Loop1;
				VDIV.F32 S6, S1, S3		; temp1=x/count
				VMUL.F32 S4, S4, S6		; temp=temp*temp1;
				VADD.F32 S5, S5, S4		; result=result+temp;
				VADD.F32 S3, S3, S7		; count++
				B Loop;
			
Loop1	 		VADD.F32 S8,S5,S10		; (1+e^z)
				VDIV.F32 S9,S5,S8		; g(z) = 1/(1+e^-z) == (e^z)/(1+e^z)
				B LP		
				
stop    B stop ; stop program
     ENDFUNC
     END 