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
 
int32_t addZiffer(int32_t* inputNumP, Terminal* keyPadTerm, bool* newInputP);

int32_t getInput (char* c);