/**
 ******************************************************************************
 * @file    stack.h
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
#include <string.h>

#define STACK_SIZE 16

int32_t stack[STACK_SIZE] = {0};
int32_t kard = 0;

int32_t push (int32_t number)
{
	if (STACK_SIZE <= kard)
	{
		return -4;
	}
	
	stack[kard] = number;
	++kard;
	
	return 0;
}

int32_t pop (int32_t* number)
{
	if (0 >= kard)
	{
		return -5;
	}
	
	--kard;
	*number = stack[kard - 1];
	stack[kard] = 0;
	
	return 0;
}

int32_t peek (int32_t* number)
{
	if (0 >= kard)
	{
		return -7;
	}
	
	*number = stack[kard - 1];
	
	return 0;
}

int32_t clearStack ()
{
	memset(stack, 0, STACK_SIZE*sizeof(int32_t));
	kard = 0;
	
	return 0;
}

int32_t getKard (int32_t* k)
{
	*k = kard;
	
	return 0;
}

int32_t getEntry (int32_t index, int32_t* entry)
{
	if (0 > index || kard <= index)
	{
		return -8;
	}
	
	*entry = stack[index];
	
	return 0;
}