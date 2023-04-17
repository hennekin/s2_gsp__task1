/**
 ******************************************************************************
 * @file    stack.h
 * @author  Jan-Hendrik Struve
 * @version 1.0
 *
 * @date    07.04.2023
 * @brief   Dieses Modul implementiert den Stack des Taschenrechners
 *
 ******************************************************************************
 */
 
#include <stdio.h>
#include <stdint.h>

int32_t push (int32_t number);

int32_t pop (int32_t* number);

int32_t peek (int32_t* number);

int32_t clearStack ();

int32_t getKard (int32_t* k);

int32_t getEntry (int32_t index, int32_t* entry);