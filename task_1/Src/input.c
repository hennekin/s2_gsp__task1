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
#include <delay.h>
#include "keypad.h"
#include "input.h"
#include "errorHandling.h"
#include "ops.h"

 /**
  * @brief  Prueft, ob ein Zeichen oder eine Nummer eingetippt wurde. 
  * Wenn eine Nummer eingetippt wird: Konstruiert int Nummer.
  * Wenn Zeichen eingetippt wurde: Rufe entsprechende Operation auf.
  * @param  
  * @retval None
  */
int32_t addZiffer (int32_t* inputNumP, Terminal* keyPadTermP, bool* newInputP)
{
	int32_t error = 0;
	char c = 0;
	int32_t value = 0;
	char charArray[2];
	
	error = getInput(&c);
	if (error) return error; 
	
	if ('0' <= c && '9' >= c)
	{
		*newInputP = false;
		value = c - '0';
			
		charArray[0] = c;					
		charArray[1] = '\0';
		printTerm(charArray, keyPadTermP);
			
		if ((INT32_MAX - *inputNumP *10 - value) < 0)
		{
			return -1;
		}
		
		*inputNumP *= 10;
		*inputNumP += value;
	}
	else
	{
		if (*newInputP)	return -50;													// error code fixen
		
		clearTerm(keyPadTermP);
		switch(c)
		{
			case 'C':
				clearOp();
				break;
			case 'p':
				error = printOne(keyPadTermP);
				if (error) return error; 
				break;
			case 'P':
				error = printAll(keyPadTermP);
				if (error) return error;
				break;
			case '+':
				error = sumOp();
				if (error) return error;
				break;
			case '-':
				error = subOp();
				if (error) return error;
				break;
			case '*':
				error = mulOp();
				if (error) return error;
				break;
			case '/':
				error = divOp();
				if (error) return error;
				break;
			case 'd':
				error = doubleOp();
				if (error) return error;
				break;
			case 'r':
				error = reverseOp();
				if (error) return error;
				break;
			case 'e':
			case '#':
			case ' ':
				error = enterOp(*inputNumP);
				if (error) return error; 
				break;
		}
		*inputNumP = 0;
		*newInputP = true;
	}
	return 0;
}

/**
  * @brief  Liest einen char aus der Terminal Eingabe.
  * @param  
  * @retval None
  */
int32_t getInput (char* c)
{
	char readC;
	
	//c = getKeyPadInput();
	readC = getchar();																	// for testing
	if (!(('0' <= readC && '9' >= readC) || 'C' ==  readC || 'P' ==  readC || 'p' ==  readC 
		|| 'e' ==  readC || '#' ==  readC || ' ' ==  readC || '+' ==  readC || '-' ==  readC 
		|| '*' ==  readC || '/' ==  readC || 'd' ==  readC || 'r' ==  readC))
	{
		return -6;
	}
	printf("Read char: %c\n", readC);
	*c = readC;
	
	return 0;
}
 
 

 