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
	
prim	fill	1000,1,1 	;ein Feld mit einem byte in dem die Stelle des Elements für die Zahl steht
result	fill	168,0,2   	;Feld ab dem die Primzahlen reingeschrieben werden

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 4

main
	ldr 	R0, =prim
	mov 	R1, #false  	;alles was keine Primzahl ist wird hiermit belegt
	strb 	R1, [R0]		;An der Position 0 wird der Byte als keine Primzahl bezeichnet
	strb 	R1, [R0, #1]	;das gleiche an Position 1, könnte auch mit ldrh gelöst werden
	mov 	R2, #2
	
	;Schleife für das maximum der Zahl
sqrt_1000
	mov 	R5, #max 		;Z
	mov		R6, #1			;R
	mov 	R7,	#-1			;C
	add 	R5,R7
while_sqrt
	cmp		R5, #0			;Z<=0
	ble endwhile_sqrt

do_sqrt
	sub 	R7, #2			;c = c-2
	add 	R6, #1			;R = R + 1
	add 	R5, R7			;Z = Z + c
	b   while_sqrt  ;loop
	
endwhile_sqrt
			

;Schleife um durch das Feld zu gehen
for_field
	mov 	R5, R6			; R5 ist die Quadratwurzel
until_field
	cmp 	R2, R5			; Wenn aktuelles Element kleiner Wurzel des Maximums, dann starte prüfung
	bge enddo_field
		
do_field
	ldrb 	R4, [R0,R2]		; Lade Wert (true/false) des Elements
	mov  	R6, R4
	b 	if_01
	
step_field
	add 	R2, #1			; Gehe zum naechsten Element des Feldes
	b 	until_field
	
enddo_field
	b 	program_end
	
;wenn dies eine Primzahl ist
if_01
	cmp 	R4, #true  		;if n != 0	; Überprüfe, ob Elemnt bereits ausgeschlossen wurde
	bne else_01
	
then_01
	mov 	R3, R2			; Kopiere Laufvariable, um zweiten faktor zu ermitteln
	b 	while_product
	
else_01
	b 	step_field
		
;innere Schleife um die Produkte der Primzahlen auszurechnen	
while_product

	cmp 	R6, #max		; Solange das Produkt kleiner als das Maximum ist
	bge endwhile_product

do_product
	mul  	R6, R3, R2		; Errechne Vielfache von Primzahl 
	strb 	R1, [R0, R6]	; Streiche vielfache von Primzahl
	add 	R3, #1
	b 	while_product

endwhile_product
	b 	step_field
	
program_end
	ldrb 	R7, [R0,#997]

;Beginn Auswertung	
for_result
	ldr 	R1, =result		; Adresse des Auswertungsfeldes laden
	mov		R2, #2			; Beginn der Auswertung bei Zahl 2

until_result
	cmp		R2, #max		; solange man noch im Feld ist, werte aus
	bgt	enddo_result
	
do_result
	ldrb	R3, [R0, R2]	; lade den Inhalt vom Element im Feld (true/false)
	b	if_02

step_result
	add 	R2, #1
	b	until_result
	
enddo_result
	b	end_result

if_02
	cmp 	R3, #true   	; if n == 1	Überprüfe, ob Element Primzahl ist
	bne else_02
	
then_02
	strh	R2, [R1], #2	; speichere die Primzahl und erhöhe die Speicheradresse um ein Halbwort
	b 	step_result
	
else_02
	b 	step_result

end_result
;--------------------------------------------
; main subroutine
;--------------------------------------------
	;EXPORT main [CODE]
	


forever	b	forever			; nowhere to retun if main ends		
	
		ALIGN
       
		END