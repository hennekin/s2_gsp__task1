/**
 ******************************************************************************
 * @file    adc.c
 * @author  Silke Behn
 *          HAW-Hamburg
 *          Labor fr technische Informatik
 *          Berliner Tor  7
 *          D-20099 Hamburg
 * @version 1.0
 *
 * @date    01.12.2020
 * @brief   Funktionen fr den Zugriff auf den ADC
 *****
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stm32f4xx_hal.h"
#include "init.h"
#include "LCD_GUI.h"
#include "LCD_Touch.h"
#include "lcd.h"

//Defines fr CCR ADC common control register
#define CR_CLEAR_MASK                     ((uint32_t)0xFFFC30E0)   
#define ADC_Mode_Independent              ((uint32_t)0x00000000) 
#define ADC_TwoSamplingDelay_8Cycles      ((uint32_t)0x00000300)
#define ADC_DMAAccessMode_Disabled        ((uint32_t)0x00000000)     /* DMA mode disabled */
#define ADC_Prescaler_Div4                ((uint32_t)0x00010000)

//defines fr CR1 ADC control register 1
#define CR1_CLEAR_MASK                    ((uint32_t)0xF73F0000)         //((uint32_t)0xFCFFEFF)
#define ADC_CR1_SCANMODE_ENABLE           ((uint32_t)0x00000100)
#define ADC_CR1_RESOLUTION_12BIT          ((uint32_t)0x00000000)   //fr 12Bit Auflsung

//defines fr CR2 ADC control register 2
#define CR2_CLEAR_MASK                    ((uint32_t)0x8080F0FC)     //    ((uint32_t)0xC0FFF7FD)
#define ADC_CR2_CONT_SINGLE               ((uint32_t)0x00000000)
#define ADC_CR2_DATA_ALIGN_RIGHT          ((uint32_t)0x00000000)
#define ADC_CR2_JEXT_DISABLE              ((uint32_t)0x00000000)

//defines fr SMPR ADC sample time register
#define SMPR_CLEAR_MASK                   ((uint32_t)0x00000007) 
#define ADC_SampleTime_15Cycles           ((uint8_t)0x01)
#define ADC_SampleTime_56Cycles           ((uint8_t)0x11)

//defines fr SQR ADC regular sequence register
#define SQR_CLEAR_MASK                    ((uint32_t)0x0000001F)  
#define RANK                              ((uint8_t) 0x1 )
void initADC(int );
int readADCValue(int );
void ADC_RegChannelConfig(int, int);
int main(){
    char sout[100];
  	int resu; int i,j;
	 	double temperatur;
	  j=1;
		initITSboard();    // Initialisierung des ITS Boards
		GUI_init(DEFAULT_BRIGHTNESS);   // Initialisierung des LCD Boards mit Touch
		TP_Init(false);                 // Initialisierung des LCD Boards mit Touch
	 initADC(3);
 	lcdSetFont(24);

	 while(j){
	 resu=0;
    ADC_RegChannelConfig(3,8);
  	for (i=0;i<400000;i++){
			resu = resu+readADCValue(3 );
		}
		resu=resu/400000;
		temperatur=0.0;
		temperatur+= 9.853715795;
		temperatur+= 0.0069940798*(double) resu;
		temperatur-= 0.00000009601129*(double) resu*(double) resu;
		temperatur+= 0.000000000025652*(double) resu*(double) resu*(double) resu;
		
		sprintf(sout,"resu=%5.2f \r",temperatur);
	  // GUI_clear(WHITE);
    lcdPrintlnS(sout);
	}

	return resu;



}