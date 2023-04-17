/**
 ******************************************************************************
 * @file    main.c
 * @author  TI Team
 *          HAW-Hamburg
 *          Labor für technische Informatik
 *          Berliner Tor  7
 *          D-20099 Hamburg
 * @version 1.1
 *
 * @date    17. Juli 2020
 * @brief   Rahmen fuer C Programme, die auf dem ITSboard ausgefuehrt werden.
 *
 *					25.04.2022 Tobias De Gasperis: printf hinzugefuegt
 ******************************************************************************
 */

#include <stdio.h>
#include <stdint.h>
#include <delay.h>
#include "stm32f4xx_hal.h"
#include "init.h"
#include "delay.h"
#include "LCD_GUI.h"
#include "LCD_Demos.h"
#include "lcd.h"
#include "fontsFLASH.h"
#include "LCD_Touch.h"
#include "error.h"
#include "terminal.h"
#include "input.h"
#include "errorHandling.h"

/**
  * @brief  Main program
  * @param  None
  * @retval None
  */
  
  
  
int main(void){
	
	initITSboard();                 // Initialisierung des ITS Boards
	GUI_init(DEFAULT_BRIGHTNESS);   // Initialisierung des LCD
	TP_Init(false);                 // Initialisierung des Touchscreens
	
	int32_t error = 0;
	int32_t inputNum = 0;
	bool newInput;
	
  Terminal keyPadTerm = makeKeyPad();	//	neues Keypad erzeugen
	
	setTextColorTerm(BLACK, &keyPadTerm);	// 	Farbe Schrift ändern
	
	//clearTerm(&keyPadTerm);				// Terminal clearen
	
    //printTerm("\n", &keyPadTerm);	//Leerzeichen printen
	
    while (true) 
	{
		error = addZiffer(&inputNum, &keyPadTerm, &newInput);
		errorHandling(error, &keyPadTerm);
		
	}
	
}

// EOF
