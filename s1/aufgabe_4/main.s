;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Silke Behn	
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main.
;					  :
;					  : Replace this main with yours.
;
;*******************************************************************************
    EXTERN initITSboard

;********************************************
; Data section, aligned on 4-byte boundery
;********************************************

	EXPORT main

true 	EQU		#1
false 	EQU 	#0
	
	AREA MyData, DATA, align = 2
	
prim	fill 	1000,1,1

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------

	
main	PROC
        BL initITSboard
		
	ldr		R0, =prim
	mov		R1, #false
	strb	R1, [R0]
	strb	R1, [R0,#1]
	mov 	R2, #2
	
for_1

	mov		R5, 32

until_1

	cmp 	R2, R5
	bge		enddo_1


do_1

	

step_1
	
	add R2, #1

enddo_1




;prim fill 1000,1,1 ein Feld mit einem byte in dem die Stelle des Elements für die Zahl steht

;lade die Adresse von prim in R0

;lade die Konstante 0 in R1  

;speichere die Konstante 0, welche in R1 steht, in einem byte ab der Adresse aus R0

;speichere die Konstante 0, welche in R1 steht, in einem byte ab der Adresse aus R0 mit 1 byte dazuaddiert

;lade die Konstante 2 in R2

;Beginn der Schleife solange R2 * R2 <= 1000 ist führe aus

{

	;lade in R4, [R0+R2]

	;if R4 ungleich 0 führe aus

	{

		;mov R3, R2

		;Beginn der Schleife solange (R2*R3)<=1000 führe aus

		{
			
			;strb R1, [R0,(R2*R3)]

			;add R3,#1

		}

	} 
	
	;add R2,#1
}



forever	b	forever		; nowhere to retun if main ends		
		ENDP
	
		ALIGN
       
		END