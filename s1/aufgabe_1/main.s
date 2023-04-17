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

; setup the peripherie - Mapping the GPIO
PERIPH_BASE     	equ	0x40000000                 
AHB1PERIPH_BASE 	equ	(PERIPH_BASE + 0x00020000)	
GPIOD_BASE			equ	(AHB1PERIPH_BASE + 0x0C00)	
	
GPIO_D				equ (GPIOD_BASE + 0x18)
	

;* We need minimal memory setup of InRootSection placed in Code Section	
	AREA  |.text|, CODE, READONLY, ALIGN = 3	
	ALIGN	
main
	BL initITSboard				; needed by the board to setup
	; Set set command
	LDR 	R6, =GPIO_D
	; Set LED register
	MOV		R0, #0xAA
	
	; Set LED
	STRB	R0, [R6] 
	b .
	
	ALIGN
	END
