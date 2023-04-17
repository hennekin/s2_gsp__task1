//Effekt auf die Register R0,R2,R3//
z.28	ldr 	R0,=VariableA	; Anw01 (Adresse des Speicherortes der Variable A wird in R0 geladen, also 0x200000C)
z.29 	ldrb 	R2,[R0]			; Anw02 (ein byte wird mit dem Inhalt des ersten bytes, von der Adresse die in R0 gespeichert ist, geladen, der Rest wird 0 gesetzt, also 0x00 EF)
z.30 	ldrb	R3,[R0,#1]		; Anw03 (ein byte wird mit dem Inhalt des zweiten bytes, von der Adresse die in R0 gespeichert ist, geladen, der Rest wird 0 gesetzt, also 0x00 BE)
z.31	lsl		R2, #8			; Anw04 (Der Inhalt des Registers R2 wird um 8 bit (1 byte) nach links innerhalb des Registers verschoben (also 0x000000EF -> 0x0000EF00))
z.32	orr		R2, R3			; Anw05 (die Binärzahl des Inhalts von R2 und R3 werden mit ODER verknüpft, das Ergebnis wird in R2 gespeichert (R2: 0x0000EFBE))
z.33	strh 	R2,[R0] 		; Anw06	(speichert zwei bytes des Inhalt des Registers R2 in die Adresse die in R0 gespeichert ist (Variable A = 0xEFBE))

z.36	mov		R5,#ConstByteA	; Anw07 (der Inhalt von ConstByteA wird in R5 geladen (R5: 0xAFFE))
z.37	strh	R5,[R0]			; Anw08 (der Inhalt von R5 wird in der Adresse die in R0 gespeichert ist gespeichert (Variable A = 0xAFFE))

z.40	ldr 	R1,=VariableB	; Anw09 (Adresse von Variable B wird in R1 geladen)
z.41	ldrh	R6,[R1]			; Anw0A (2 bytes von Variable B werden in R6 geladen (R6: 0x0034))
z.42	mov		R7, #0x30ED		; Anw0B






 
