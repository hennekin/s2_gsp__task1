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
#include "terminal.h"

int32_t clearOp();

int32_t printOne(Terminal* keyPadTermP);

int32_t printAll(Terminal* keyPadTermP);

int32_t sumOp();

int32_t subOp();

int32_t mulOp();

int32_t divOp();

int32_t doubleOp();

int32_t reverseOp();

int32_t enterOp(int32_t number);
 