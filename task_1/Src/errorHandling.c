/**
 ******************************************************************************
 * @file    errorHandling.h
 * @author  Jan-Hendrik Struve
 * @version 1.0
 *
 * @date    07.04.2023
 * @brief   Dieses Modul implementiert die Handhabung von auftretenden Errors
 *
 ******************************************************************************
 */
 
#include <stdio.h>
#include <stdint.h>
#include "terminal.h"
#include "LCD_GUI.h"
#include "input.h"
#include "ops.h"
 
 
/**
  * @brief  Prueft anhand des Fehlercodes, ob Fehler aufgetreten ist.
  *	Wenn ja: Gibt passsenden Fhelertext aus und wartet, bis reinitialisiert wurde.
  * @param  
  * @retval None
  */
void errorHandling(int32_t error,  Terminal* keyPadTermP)
{
	char c;
	
	if (error)
	{
		clearTerm(keyPadTermP);
		setTextColorTerm(RED, keyPadTermP);
		switch(error)
		{
			case -1: printTerm("Input num too big, press C", keyPadTermP);
				break;
			case -2: printTerm("Division with 0 , press C", keyPadTermP);
				break;
			case -3: printTerm("MAX_INT exceeded, press C", keyPadTermP);
				break;
			case -4: printTerm("Stack overflow, press C", keyPadTermP);
				break;
			case -5: printTerm("Stack underflow, press C", keyPadTermP);
				break;
			case -6: printTerm("Wrong input, press C", keyPadTermP);
				break;
			case -7: printTerm("peek on empty stack, press C", keyPadTermP);
				break;
			case -8: printTerm("index out of bounce, press C", keyPadTermP);
				break;
			case -9: printTerm("empty input, press C", keyPadTermP);
				break;
			default: printTerm("Unknown error, press C", keyPadTermP);
		}
		while ('C' != c)
		{
			getInput(&c);
		}
		clearOp();
		clearTerm(keyPadTermP);
		setTextColorTerm(BLACK, keyPadTermP);
		
		return;
	}
	else
	{
		return;
	}
}