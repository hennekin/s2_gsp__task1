Semantik er einzelnen Aussagen:


mov   r0,#0x12                      ; Anw-01    lade die Hexadezimal-Konstante 12 in das Register r0
mov   r1,#-128                      ; Anw-02    lade die Dezimal-Konstante -128 in das Register r1
ldr   r2,=0x12345678                ; Anw-03    lade die Hexadezimal-Konstante 12345678 in das Register r2

ldr   r0,=VariableA                 ; Anw-04    lade die Adresse der VariableA in das Register r0
ldrh  r1,[r0]                       ; Anw-05    lade ein Halbwort ab der Adresse die in r0 gespeichert ist in r1
ldr   r2,[r0]                       ; Anw-06    lade ein Wort ab der Adresse die in r0 gespeichert ist in r1
str   r2,[r0,#VariableC-VariableA]  ; Anw-07    speichere den Inhalt des Registers r2 in der Adresse, die in r0 steht plus den Abstand der Speicheradressen von VariableC minus VariableA


ldr   r0,=MeinHalbwortFeld          ; Anw-08    lade die Adresse von MeinhalbwortFeld in das Register r0
ldrh  r1,[r0]                       ; Anw-09    lade ein Halbwort ab der Adresse die in r0 gespeichert ist in r1
ldrh  r2,[r0,#2]                    ; Anw-10    lade ein Halbwort ab der Adresse die in r0 plus 2 gespeichert ist in r2
mov   r3,#10                        ; Anw-11    lade die Dezimal-Konstante 10 in das Register r3
ldrh  r4,[r0,r3]                    ; Anw-12    lade ein Halbwort ab der Adresse die in r0, plus das in r3 gespeicherte(10 Dezimal), gespeichert ist in r4

ldrh  r5,[r0,#2]!                   ; Anw-13    lade ein Halbwort ab der Adresse die in r0 plus 2 gespeichert ist in r5                                              
ldrh  r6,[r0,#2]!                   ; Anw-14    lade ein Halbwort ab der Adresse die in r0 plus 2 plus die zuvor addierten 2 gespeichert ist in r2
strh  r6,[r0,#2]!                   ; Anw-15    speichere den Inhalt des Registers r6 in der Adresse, die in r0 steht plus 2 und die zuvor addierten 4 (6)

ldr  r0,=MeinWortFeld               ; Anw-16    lade die Adresse von MeinWortFeld in das Register r0
ldr  r1,[r0]                        ; Anw-17    lade ein Wort ab der Adresse die in r0 gespeichert ist in r1
ldr  r2,[r0,#4]                     ; Anw-18    lade ein Wort ab der Adresse plus 4 die in r0 gespeichert ist in r2 
adds r3,r1,r2                       ; Anw-19    addiere die Register r1 und r2, speichere das Ergebnis in r3
ldr  r4,[r0,#8]                     ; Anw-20    lade ein Wort ab der Adresse plus 8 die in r0 gespeichert ist in r4
ldr  r5,[r0,#12]                    ; Anw-21    lade ein Wort ab der Adresse plus 12 die in r0 gespeichert ist in r5
subs r6,r4,r5                       ; Anw-22    subtrahiere das Register r5 von r4, speichere das Ergebnis in r6

ldr  r7,[r0,#16]                    ; Anw-23    lade ein Wort ab der Adresse plus 16 die in r0 gespeichert ist in r7
ldr  r8,[r0,#20]                    ; Anw-24    lade ein Wort ab der Adresse plus 20 die in r0 gespeichert ist in r8
subs r9,r7,r8                       ; Anw-25    subtrahiere das Register r8 von r7, speichere das Ergebnis in r9

