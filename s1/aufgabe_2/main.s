;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke	
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to setup three LEDs
;					  :
;					  : 
;
;*******************************************************************************
	EXTERN initITSboard ; Helper to organize the setup of the board

	EXPORT main  		; we need this for the linker - In this context it set the entry point,too

ConstByteA	EQU 0xaffe
	
;* We need some data to work on
	AREA DATA, DATA, align=2 	
VariableA 	DCW 0xbeef
VariableB	DCW 0x1234
VariableC	DCW	0x0000

;* We need minimal memory setup of InRootSection placed in Code Section	
	AREA  |.text|, CODE, READONLY, ALIGN = 3	
	ALIGN	
main
	BL initITSboard				; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
	ldr 	R0,=VariableA	; Anw01
	ldrb 	R2,[R0]			; Anw02
	ldrb	R3,[R0,#1]		; Anw03
	lsl		R2, #8			; Anw04
	orr		R2, R3			; Anw05
	strh 	R2,[R0] 		; Anw06	
  	
;* const in var
	mov		R5, #ConstByteA	; Anw07
	mov		R4, R5			; 0xaffe in R4 laden
	and		R4, #0xFF		; 0xaffe mit FF maskieren, Ergebnis FE in R4 speichern
	and		R5, #0xFF00		; 0xaffe mit FF00 maskieren, Ergebnis AF00 in R5 speichern
	lsl     R4, #8			; FE um 8 Bit nach links schieben
	lsr		R5, #8			; AF00 um 8 Bit nach rechts schieben
	orr		R4, R5			; Wortstücke zusammenführen
	ldr		R5, =VariableC	; Speicherort laden
	strh	R4,[R5]			; Anw08 im Speicher an Position von VariableC speichern
	
;* Change value from x1234 to x4321
	ldr 	R1,=VariableB	; Anw09
	ldrh	R6,[R1]			; Anw0A
	mov		R7, #0x21DE		; Anw0B
	add		R6, R6, R7		; Anw0C
	strh	R6,[R1]			; Anw0D
	;oder
	;mov	R7, #0x3412
	;strh	R7, [R1]
	b .						; Anw0E
	
	ALIGN
	END