;------------------------------------------------------------------------------------------------------
; Design and Implementation of an AHB timer, a GPIO peripheral, and a 7-segment display peripheral  
; 1)Display text string: "TEST" on VGA.
; 2)Input data from switches and output them to LEDs;
; 3)Display the timer value to the 7-segment display.
;------------------------------------------------------------------------------------------------------


; Vector Table Mapped to Address 0 at Reset

						PRESERVE8
                		THUMB

        				AREA	RESET, DATA, READONLY	  			; First 32 WORDS is VECTOR TABLE
        				EXPORT 	__Vectors
					
__Vectors		    	DCD		0x00003FFC
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

				;Configure the timer
				
				LDR 	R1, =0x52000000		;timer load value register
				LDR 	R0, =0xFFFFFFFF		;maximum load value
				STR		R0,	[R1]			
				LDR 	R1, =0x52000008		;timer control register
				MOVS	R0, #0x07			;set prescaler, reload mode, start timer
				STR		R0,	[R1]
				

AGAIN			

				;Read the current timer value, and output to 7-segments
				
				LDR 	R1, =0x52000004		;timer current value register
				LDR		R3,	[R1]
				LSRS	R3,	R3, #16			;choose the higher 16 bits

				
				MOVS	R0,	R3				;display the 1st digit
				LDR 	R2, =0x0F
				ANDS    R0, R0, R2
				LDR 	R1, =0x54000000
				STR		R0, [R1]


				LSRS	R0,	R3, #4			;display the 2nd digit
				LDR 	R2, =0x0F
				ANDS    R0, R0, R2
				LDR 	R1, =0x54000004
				STR		R0, [R1]
				
				
				
				LSRS	R0,	R3, #8			;display the 3rd digit
				LDR 	R2, =0x0F
				ANDS    R0, R0, R2
				LDR 	R1, =0x54000008
				STR		R0, [R1]
				
				
				LSRS	R0,	R3, #12			;display the 4th digit
				LDR 	R2, =0x0F
				ANDS    R0, R0, R2
				LDR 	R1, =0x5400000C
				STR		R0, [R1]					
			
				
				B		AGAIN		


				ENDP

				ALIGN 		4					 ; Align to a word boundary

		END  
