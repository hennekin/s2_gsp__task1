/**
 ******************************************************************************
 * @file    input.h
 * @author  Jan-Hendrik Struve
 * @version 1.0
 *
 * @date    27.03.2023
 * @brief   Dieses Modul implementiert die eingabe und Auswertungn von Symbolen und Zeichen
 *
 ******************************************************************************
 */
 
#include <stdio.h>
#include <stdint.h>
#include "keypad.h"
#include "input.h"

/**
  * @brief  Liest einen char aus der Terminal Eingabe.
  * @param  
  * @retval None
  */
int32_t getInput (int* inputNumP, char* command)
{
	char readC;
	int32_t value = 0;
	char charArray[2];
	
	do
	{
	
	//c = getKeyPadInput();
	readC = getchar();																	// for testing
	if (!(('0' <= readC && '9' >= readC) || 'C' ==  readC || 'P' ==  readC || 'p' ==  readC 
		|| 'e' ==  readC || '#' ==  readC || ' ' ==  readC || '+' ==  readC || '-' ==  readC 
		|| '*' ==  readC || '/' ==  readC || 'd' ==  readC || 'r' ==  readC))
	{
		return -6;
	}
	
	} while ('0' <= readC && '9' >= readC);
	
	if ('0' > readC || '9' < readC)
	{
		return -9;
	}
	
	return 0;
}
 
 

 