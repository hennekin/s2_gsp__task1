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
    EXTERN lcdPrintS            ;Display ausgabe
	EXTERN lcdPrintC	
	EXTERN lcdPrintlnS	
	EXTERN lcdGotoXY	
    EXTERN GUI_init
	EXTERN TP_Init
    EXTERN initTimer



;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	
	AREA MyData, DATA, align = 2
	
	    
DEFAULT_BRIGHTNESS DCW  800
TXT 				DCB "00:00:00", 0			; Schreibe Text "Hallo in txt Variable

;Adressen aus der CMSIS
;\stm32cubef4\Drivers\CMSIS\Device\ST\STM32F4xx\Include\stm32f429xx.h


; setup the peripherie - Mapping the GPIO
PERIPH_BASE     	equ	0x40000000                 
AHB1PERIPH_BASE 	equ	(PERIPH_BASE + 0x00020000)	
GPIO_D_BASE			equ	(AHB1PERIPH_BASE + 0x0C00)	
GPIO_E_BASE          equ (AHB1PERIPH_BASE + 0x1000)	
GPIO_F_BASE          equ (AHB1PERIPH_BASE + 0x1400)

GPIO_D_PIN			equ	(GPIO_D_BASE + 0x10)
GPIO_D_SET			equ (GPIO_D_BASE + 0x18)
GPIO_D_CLR			equ	(GPIO_D_BASE + 0x1A)	 


GPIO_F_PIN           equ (GPIO_F_BASE + 0x10) 	


APB1PERIPH_BASE     equ  PERIPH_BASE
TIM2_BASE           equ (APB1PERIPH_BASE + 0x0000)

TIM2_CR1            equ (TIM2_BASE)
TIM2_CNT			equ (TIM2_BASE + 0x24)   ; CNT : current time stamp (32 bit),  resolution
TIM2_PSC			equ (TIM2_BASE + 0x28)   ; Prescaler  resolution
TIM2_EGR			equ (TIM2_BASE + 0x14)   ; 16 Bit register, Bit 0 : 1 Restart Timer	
TIM2_ARR            equ (TIM2_BASE + 0x2C)
	
STATE_INIT			equ	1
STATE_HOLD			equ	2
STATE_RUN			equ	3

LED1				equ	1
LED2				equ	2
LED3				equ	3
	

	

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
main	PROC
        BL 			initITSboard
		
		MOV 		R1, 		#800			; Helligkeit festlegen und Display initialisieren
		LDRH 		R0, 		[R1]
		BL 			GUI_init
		
		MOV 		R0, 		#0x00			; ?
		BL 			TP_Init
		
		BL 			initTimer
		
		MOV			R0, 		#10
		MOV			R1, 		#10
		BL 			lcdGotoXY
		LDR			R0,			=TXT			; Gebe string "Hallo" auf LCD aus
  		BL 			lcdPrintS	

		LDR			R12,		=STATE_INIT		; Start State auf Init
		
main_loop
		LDR 		R0,			=GPIO_F_PIN		; einlesen der Taster
		LDRB 		R1, 		[R0]
		
		; LED TASTER TEST
		; ldr 		R0, 		=GPIO_D_CLR
		; strb		R1, 		[R0]				
		; mvn		R1,			R1
		; ldr 		R0, 		=GPIO_D_SET
		; strb		R1, 		[R0]
		
		MVN			R1,			R1				; Switch:: S5: State=1 (init), S6: State=2 (hold), S7: State=3 (run), Default: k. verä.
if_S5
		TST 		R1,			#0x1<<5
		BEQ			end_if_S5	
		LDR			R12,			=STATE_INIT
end_if_S5	

if_S6
		TST 		R1,			#0x1<<6
		BEQ			end_if_S6	
		LDR			R12,			=STATE_HOLD
end_if_S6

if_S7
		TST 		R1,			#0x1<<7
		BEQ			end_if_S7
		LDR			R12,			=STATE_RUN
end_if_S7

		CMP			R12,			#2				; Rufe richtiges Unterprogramm auf: STATE < 2 => INIT, STATE = 2 => HOLD, STATE > 2 => RUN
		BLO			state_init
		BEQ			state_hold
		BHI			state_run
		
state_init
		LDR			R0, 		=GPIO_D_CLR		; Keine led leuchten lassen
		MOV			R1,			#0xFF
		STRB		R1,			[R0]
		B			main_loop
		; Setze gestoppte Zeitspanne auf 0

state_hold
		LDR			R0, 		=GPIO_D_SET		; D8 u D9 leuchten lassen
		MOV			R1,			#0x3
		STRB		R1,			[R0]	
		B			main_loop
		; Akt Zeit abspeichern

state_run
		LDR			R0, 		=GPIO_D_SET		; Nur D8 leuchten lassen
		MOV			R1,			#0x1
		STRB		R1,			[R0]	
		LDR			R0, 		=GPIO_D_CLR
		MOV			R1,			#0x2
		STRB		R1,			[R0]
		B			main_loop
		
		; Aktualisieren Zeitspanne

update_time ; Udiff nachgoogeln

update_leds PROC
		push 		{R0, R1, LR}
		
		pop 		{R0, R1, PC}
		ENDP
		
update_tft		
		
		
		b 			main_loop
        ENDP

		ALIGN
		END