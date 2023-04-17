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
		

true 	EQU		1			
false	EQU		0
max     EQU     1000
	
	AREA MyData, DATA, align = 2
	
prim	fill	1000,1,1 ;ein Feld mit einem byte in dem die Stelle des Elements für die Zahl steht

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 4

main
	ldr R0, =prim
	mov R1, #false  ;alles was keine Primzahl ist wird hiermit belegt
	strb R1, [R0]	;An der Position 0 wird der Byte als keine Primzahl bezeichnet
	strb R1, [R0, #1] ;das gleiche an Position 1, könnte auch mit ldrh gelöst werden
	mov R2, #2
	
	;Schleife für das maximum der Zahl

sqrt_1000
	mov R5, #max 	;Z
	mov	R6, #1		;R
	mov R7,	#-1		;C
	add R5,R7
while_sqrt
	cmp	R5, #0		;Z<=0
	ble endwhile_sqrt

do_sqrt
	sub R7, #2		;c = c-2
	add R6, #1		;R = R + 1
	add R5, R7		;Z = Z + c
	b   while_sqrt  ;loop
endwhile_sqrt
	mov R5, R6		;R5 ist die Quadratwurzel

	;Schleife um durch das Feld zu gehen
for_field
	;Initialisierung

until_field
		cmp R2, R5
		bge enddo_field
do_field
	ldrb R4, [R0,R2]
	mov  R6, R4
	
	;wenn dies eine Primzahl ist
if_01
	cmp R4, #0   ;if n != 0
	beq else_01
	
then_01
	mov R3, R2
	b while_product
	
else_01
		b step_field
		
		
		;innere Schleife um die Produkte der Primzahlen auszurechnen	
while_product

	cmp R6, #max
	bge endwhile_product

do_product
	mul  R6, R3, R2
	strb R1, [R0, R6]
	add R3, #1
	b while_product

endwhile_product

	;äußere Schleife		
step_field
		add R2, #1
		b until_field
enddo_field

		ldrb R7, [R0,#997]




;--------------------------------------------
; main subroutine
;--------------------------------------------
	;EXPORT main [CODE]
	


forever	b	forever		; nowhere to retun if main ends		
	
		ALIGN
       
		END