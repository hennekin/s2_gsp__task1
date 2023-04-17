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
STATE_RUNNING		equ	3

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
        bl 			initITSboard
		
		mov 		R1, 		#800			; Helligkeit festlegen und Display initialisieren
		ldrh 		R0, 		[R1]
		bl  		GUI_init
		
		mov 		R0, 		#0x00			; ?
		bl 			TP_Init
		
		bl			initTimer
		
		mov			R0, 		#10
		mov			R1, 		#10
		bl 			lcdGotoXY
		; ldr			R0,			=TXT			; Gebe string aus
		; bl 			lcdPrintS	

		ldr			R12,		=STATE_INIT		; Start State auf Init    

state_init
		; Ruft Unterprogramm zum updaten der Leds auf
		; Ruft Unterprogramm zum updaten des TFT auf
		
state_loop_init
		bl update_state							; Ruft Unterprogramm zum Abfragen der Taster und updaten des States auf
		; Wenn State geupdatet wurde, springe in neuen State
			
state_hold
		; Speichert die aktuelle Zeit zwischen
		; Ruft Unterprogramm zum updaten der Leds auf
		; Ruft Unterprogramm zum updaten des TFT auf
		
state_loop_hold
		bl update_state							; Ruft Unterprogramm zum Abfragen der Taster und updaten des States auf

state_runing
		bl update_time
		bl update_tft
		; Ruft Unterprogramm zum updaten der Leds auf

state_loop_runing
		bl update_state							; Ruft Unterprogramm zum Abfragen der Taster und updaten des States auf
		; Wenn State geupdatet wurde, springe in neuen State
		; Speichert die aktuelle Zeit zwischen
		; Ruft Unterprogramm zum updaten des TFT auf
		
		ENDP


update_state PROC								; S5: State=1 (init), S6: State=2 (hold), S7: State=3 (run)
		push 		{r0, r1, lr}
		
		LDR 		R0,			=GPIO_F_PIN		; einlesen der Taster
		LDRB 		R1, 		[R0]
		MVN			R1,			R1

		CMP			R12,			#2			; Switch: Rufe richte Taster Abfrage auf: STATE < 2 => INIT, STATE = 2 => HOLD, STATE > 2 => RUN
		BLO			update_state_init
		BEQ			update_state_hold
		BHI			update_state_running		
		
update_state_init								; Wechsle zu state: S7: State=3 (running)
if_init_s7				
		TST 		R1,			#0x1<<7
		BEQ			end_if_init_s7
		LDR			R12,		=STATE_RUNNING
end_if_init_s7
		b			end_update_state

update_state_hold								; Wechsle zu state: S5: State=1 (init), S6: State=2 (hold)
if_hold_s5
		TST 		R1,			#0x1<<5
		BEQ			end_if_hold_s5
		LDR			R12,		=STATE_INIT
end_if_hold_s5

if_running_s7
		TST 		R1,			#0x1<<7			
		BEQ			end_if_running_s7	
		LDR			R12,		=STATE_RUNNING	
end_if_running_s7
		b			end_update_state

update_state_running							; Wechsle zu state: S5: State=1 (init), S7: State=3 (running)
if_running_s5
		TST 		R1,			#0x1<<5
		BEQ			end_if_running_s5
		LDR			R12,		=STATE_INIT
end_if_running_s5

if_hold_s6
		TST 		R1,			#0x1<<6				
		BEQ			end_if_hold_s6	
		LDR			R12,		=STATE_HOLD	
end_if_hold_s6

end_update_state
		pop 		{r0, r1, pc}
		ENDP

update_time PROC
		push 		{r0, lr}
		ldr 		r0,			=TIM2_CNT
		ldr 		r1,			[r0]
		mov 		r2,			#1000
		udiv		r11, 		r2
		; Aktualisiert zwischengespeicherte Zeit
		pop 		{r0, pc}
		ENDP

update_leds PROC
		push 		{lr}
		; Aktualisiert dir Leds je nach State
		pop 		{pc}
		ENDP

update_tft PROC
		push 		{r0, lr}
		mov			r0, 		r11
		bl 			modulo	
		; Aktualisiert tft mit übergebener Zeit
		pop 		{r0, pc}
		ENDP
			
modulo PROC
		push 		{r1, r3, lr}
		mov 		r1,			#0
		mov 		r3,			#10
while_modulo
		cmp 		r0,			r3
		blt			end_while_modulo
		sub			r0, 		r3
		add			r1,			#1
		b while_modulo
end_while_modulo
		mov 		r4,			r0
		add 		r0, 		#'0'
		bl			lcdPrintC
		
		
		
		; Aktualisiert dir Leds je nach State
		pop 		{r1, r3, pc}
		ENDP

		ALIGN
		END