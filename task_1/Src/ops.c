/**
 ******************************************************************************
 * @file    ops.h
 * @author  Jan-Hendrik Struve
 * @version 1.0
 *
 * @date    07.04.2023
 * @brief   Dieses Modul implementiert alle Operatoren des Taschenrechners
 *
 ******************************************************************************
 */
 
#include <stdio.h>
#include <stdint.h>
#include "stack.h"
#include "errorHandling.h"
#include "stack.h"
#include "terminal.h"

/**
  * @brief Resettet den Taschenrechner
  * @param  
  * @retval None
  */
int32_t clearOp()
{
	int32_t error;
	error = clearStack();
	if (error) return error;
	
	return 0;
}

/**
  * @brief Druckt den ersten eintrag des Stacks aus, ohne ihn zu veraendern.
  * @param  
  * @retval None
  */
int32_t printOne(Terminal* keyPadTermP)
{
	int32_t error;
	int32_t kard = 0;
	int32_t entry = 0;
	char entryCharArr[11] = {NULL};
	
	error = peek(&entry);
	if (error) return error;
	
	sprintf(entryCharArr, "%d", entry);
	printTerm(entryCharArr, keyPadTermP);
	printTerm("\n", keyPadTermP);
	
	return 0;
}

/**
  * @brief Druckt alle Eintraege des Stacks aus, ohne ihn zu veraendern.
  * @param  
  * @retval None
  */
int32_t printAll(Terminal* keyPadTermP)
{
	int32_t error = 0;
	int32_t kard = 0;
	int32_t entry = 0;
	char entryCharArr[11] = {0};
	
	error = getKard(&kard);
	if (error) return error;
	
	
	for (int32_t i = 0; i < kard; ++i)
	{
		error = getEntry(i, &entry);
		if (error) return error;
		sprintf(entryCharArr, "%d", entry);
		printTerm(entryCharArr, keyPadTermP);
		printTerm("\n", keyPadTermP);
		
	}
	return 0;
}

/**
  * @brief Nimmt zwei Werte von Stack, addiert sie, packt sie wieder auf den Stack.
  * @param  
  * @retval None
  */
int32_t sumOp()
{
	int32_t error = 0;
	int32_t firstValue = 0;
	int32_t secondValue = 0;
	int32_t result = 0;
	
	error = pop(&firstValue);
	if (error) return error;
	error = pop(&secondValue);
	if (error) return error;
	
	result = secondValue + firstValue;
	error = push(result);
	if (error) return error;
	
	return 0;
}

/**
  * @brief Nimmt zwei Werte von Stack, subtrahiert obersten vom zweitobersten, packt sie wieder auf den Stack.
  * @param  
  * @retval None
  */
int32_t subOp()
{
	int32_t error = 0;
	int32_t firstValue = 0;
	int32_t secondValue = 0;
	int32_t result = 0;
	
	error = pop(&firstValue);
	if (error) return error;
	error = pop(&secondValue);
	if (error) return error;
	
	result = secondValue - firstValue;
	error = push(result);
	if (error) return error;
	
	return 0;
}

/**
  * @brief Nimmt zwei Werte von Stack, multipliziert sie, packt sie wieder auf den Stack.
  * @param  
  * @retval None
  */
int32_t mulOp()
{
	int32_t error = 0;
	int32_t firstValue = 0;
	int32_t secondValue = 0;
	int32_t result = 0;
	
	error = pop(&firstValue);
	if (error) return error;
	error = pop(&secondValue);
	if (error) return error;
	
	result = secondValue * firstValue;
	error = push(result);
	if (error) return error;
	
	return 0;
}

/**
  * @brief Nimmt zwei Werte von Stack, dividiert zweitobersten durch obersten, packt sie wieder auf den Stack.
  * @param  
  * @retval None
  */
int32_t divOp()
{
	int32_t error = 0;
	int32_t firstValue = 0;
	int32_t secondValue = 0;
	int32_t result = 0;
	
	error = pop(&firstValue);
	if (error) return error;
	error = pop(&secondValue);
	if (error) return error;
	
	result = secondValue / firstValue;
	error = push(result);
	if (error) return error;
	
	return 0;
}

/**
  * @brief Dupliziert obersten Stack eintrag.
  * @param  
  * @retval None
  */
int32_t doubleOp()
{
	int32_t error = 0;
	int32_t doubleValue = 0;
	
	error = peek(&doubleValue);
	if (error) return error;
	error = push(doubleValue);
	if (error) return error;
	
	return 0;
}

/**
  * @brief Vertauscht oberste Stack Eintraege.
  * @param  
  * @retval None
  */
int32_t reverseOp()
{
	int32_t error = 0;
	int32_t firstValue = 0;
	int32_t secondValue = 0;
	
	pop(&secondValue);
	pop(&firstValue);
	
	push(secondValue);
	push(firstValue);
	
	return 0;
}

/**
  * @brief Schreibt aktuell eingegebene Zahl auf Stack.
  * @param  
  * @retval None
  */
int32_t enterOp(int32_t number)
{
	int32_t error = 0;
	printf("number pushed: %d\n", number);									// for testing
	push(number);
	
	return 0;
}









