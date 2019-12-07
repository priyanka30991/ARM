	AREA     neural, CODE, READONLY
		EXPORT __main
		IMPORT printMsg
		IMPORT printMsg2p
		IMPORT printMsg4p
     		 
		ENTRY 
__main  FUNCTION
	
	    BL printMsg4p;
		  
level1    VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=0; x2
		  VLDR.F32 S13,=0; x3
		  
		  VCVT.U32.F32 S11,S11 ;
		  VMOV.F32 R0,S11 ;
		  BL printMsg ;
		  VCVT.U32.F32 S12,S12 ;
		  VMOV.F32 R0,S12 ;
		  BL printMsg ;
		  VCVT.U32.F32 S13,S13 ;
		  VMOV.F32 R0,S13 ;
		  BL printMsg ;
		  VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=0; x2
		  VLDR.F32 S13,=0; x3
		  B LOGIC_GATES;
		  
level2    VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=0; x2
		  VLDR.F32 S13,=1; x3
		  
		  VCVT.U32.F32 S11,S11 ;
		  VMOV.F32 R0,S11 ;
		  BL printMsg ;
		  VCVT.U32.F32 S12,S12 ;
		  VMOV.F32 R0,S12 ;
		  BL printMsg ;
		  VCVT.U32.F32 S13,S13 ;
		  VMOV.F32 R0,S13 ;
		  BL printMsg ;
		  VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=0; x2
		  VLDR.F32 S13,=1; x3
		  B LOGIC_GATES;
		
level3    VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=1; x2
		  VLDR.F32 S13,=0; x3
		  
		  VCVT.U32.F32 S11,S11 ;
		  VMOV.F32 R0,S11 ;
		  BL printMsg ;
		  VCVT.U32.F32 S12,S12 ;
		  VMOV.F32 R0,S12 ;
		  BL printMsg ;
		  VCVT.U32.F32 S13,S13 ;
		  VMOV.F32 R0,S13 ;
		  BL printMsg ;
		  VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=1; x2
		  VLDR.F32 S13,=0; x3
		  B LOGIC_GATES;

level4    VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=1; x2
		  VLDR.F32 S13,=1; x3
		  
		  VCVT.U32.F32 S11,S11 ;
		  VMOV.F32 R0,S11 ;
		  BL printMsg ;
		  VCVT.U32.F32 S12,S12 ;
		  VMOV.F32 R0,S12 ;
		  BL printMsg ;
		  VCVT.U32.F32 S13,S13 ;
		  VMOV.F32 R0,S13 ;
		  BL printMsg ;
		  VLDR.F32 S11,=1; x1
		  VLDR.F32 S12,=1; x2
		  VLDR.F32 S13,=1; x3
		  B LOGIC_GATES;
		  
				
LOGIC_GATES
LOGIC_NAND      VLDR.F32  S14,=0.6	;W1
				VLDR.F32  S15,=-0.8	;W2       0
				VLDR.F32  S16,=-0.8	;W3
				VLDR.F32  S17,=0.3	;BIAS
				B Z_CALC
							
LOGIC_NOR       VLDR.F32  S14,=0.5	;W1
				VLDR.F32  S15,=-0.7	;W2       1
				VLDR.F32  S16,=-0.7	;W3
				VLDR.F32  S17,=0.1	;BIAS
				B Z_CALC
				
LOGIC_AND       VLDR.F32  S14,=-0.1	;W1
				VLDR.F32  S15,=0.2	;W2        2
				VLDR.F32  S16,=0.2	;W3
				VLDR.F32  S17,=-0.2	;BIAS
				B Z_CALC
				
LOGIC_OR        VLDR.F32  S14,=-0.1	;W1
				VLDR.F32  S15,=0.7	;W2        3
				VLDR.F32  S16,=0.7	;W3
				VLDR.F32  S17,=-0.1	;BIAS
				B Z_CALC
				
LOGIC_NOT       VLDR.F32  S14,=0.5	;W1
				VLDR.F32  S15,=-0.7	;W2        4
				VLDR.F32  S16,=0	;W3
				VLDR.F32  S17,=0.1	;BIAS
				B Z_CALC
				
Z_CALC    	    VMUL.F32  S18,S11,S14  ;w1*x1
                VADD.F32  S19,S19,S18  ;
		        VMUL.F32  S18,S12,S15  ;w2*x2
				VADD.F32  S19,S19,S18  ;
				VMUL.F32  S18,S13,S16  ;w3*x3 
				VADD.F32  S19,S19,S18  ;(w1*x1 + w2*x2 + w3*x3)
                VADD.F32  S19,S19,S17  ;(w1*x1 + w2*x2 + w3*x3) + bias
				B SIGMOID					 	
        	 
SIGMOID		VMOV.F32 S1, S19; x:Number to find e^x
	        VMOV.F32 S2, #30; Number of iterations for e^x expansion
			VMOV.F32 S3, #1;  count
			VMOV.F32 S4, #1;  temp variable
			VMOV.F32 S5, #1;  result initialized to 1
			VMOV.F32 S7, #1;  register to hold 1
			VMOV.F32 S10,#1;

Loop 		VCMP.F32 S2, S3; Comparison done for excuting taylor series expansion of e^x for s2 number of terms
			VMRS.F32 APSR_nzcv,FPSCR; to copy fpscr to apsr
			BLT Loop1;
			VDIV.F32 S6, S1, S3; temp1=x/count
			VMUL.F32 S4, S4, S6; temp=temp*temp1;
			VADD.F32 S5, S5, S4; result=result+temp;
			VADD.F32 S3, S3, S7; count++
			B Loop;
			
Loop1	 	VADD.F32 S8,S5,S10;  (1+e^z)
			VDIV.F32 S9,S5,S8;	  g(z) = 1/(1+e^-z) == (e^z)/(1+e^z)
			VLDR.F32 S18,=0;
			VLDR.F32 S19,=0;
			B OUTPUT;
	 
OUTPUT		VLDR.F32 S20,=0.5
			VCMP.F32 S9,S20
			VMRS.F32 APSR_nzcv,FPSCR;Used to copy fpscr to apsr
			ITE HI			; if g(z) > 0.5 , print 1 else print 0
			MOVHI R0,#1
			MOVLS R0,#0		
			BL printMsg
			ADD R5,R5,#1;	
			CMP R5,#1
			BEQ LOGIC_NOR
			CMP R5,#2
			BEQ LOGIC_AND
			CMP R5,#3
			BEQ LOGIC_OR
			CMP R5,#4
			BEQ LOGIC_NOT
			
			LDR R5,=0;
			
			BL printMsg2p;
			ADD R6,R6,#1;
			CMP R6,#1		
			BEQ level2;		
			CMP R6,#2
			BEQ level3;
			CMP R6,#3
			BEQ level4;
			
			B stop;
			
stop        B   stop	
		  
ENDFUNC
END