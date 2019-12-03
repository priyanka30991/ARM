;------------------------------------------------------------------------------------------------------
; A Simple SoC  Application
; Toggle LEDs at a given frequency. 
;------------------------------------------------------------------------------------------------------



; Vector Table Mapped to Address 0 at Reset

						PRESERVE8
                		THUMB

        				AREA	RESET, DATA, READONLY	  			; First 32 WORDS is VECTOR TABLE
        				EXPORT 	__Vectors
					
__Vectors		    	DCD		0x00003FFC							; 1K Internal Memory
        				DCD		Reset_Handler
        				DCD		0  			
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD 	0
        				DCD		0
        				DCD		0
        				DCD 	0
        				DCD		0
        				
        				; External Interrupts
						        				
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
        				DCD		0
              
                AREA |.text|, CODE, READONLY
;Reset Handler
Reset_Handler   PROC
                GLOBAL Reset_Handler
                ENTRY

				LDR R1,=1 ; initial value
				LDR R3,=1 ; initializing product to 1
				LDR R2,=5 ; for 5!
						
FACT    		CMP R1,R2 ; this computes the factorial
				BEQ AGAIN  ;
		
				MULS R3,R2,R3 ; Product = product*r2
				SUBS R2,R2,#1 ; decrement the value
				B FACT ;


AGAIN		   	LDR 	R1, =0x50000000				;Write to LED with value 0x55
				MOV		R0,R3 ;
				STR		R0, [R1]



;				LDR		R0, =0x2F				;Delay
;Loop			SUBS	R0,R0,#1
;				BNE Loop

;				LDR 	R1, =0x50000000				;Write to LED with value 0xAA
;				LDR		R0, =0xAA
;				STR		R0, [R1]

;				LDR		R0, =0x2F				;Delay
;Loop1			SUBS	R0,R0,#1
;				BNE Loop1

;				B AGAIN
;				ENDP


				ALIGN 		4						; Align to a word boundary

		END    
