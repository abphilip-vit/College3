ORG 0000H
SETB P3.5
CLR P1.2
MOV P2, #00H
; Clear P2
MOV TMOD, #01100001B
; Counter-1 Mode-2 & Timer-0 Mode-1

MOV TH1, #00H
SETB TR1

HERE:
MOV A, TL1
MOV P2, A
; Gives the value of TL1 to P2	
CPL P3.5
MOV R7, #07H
MOV R6, #0FFH
MOV R5, #0FFH

ACALL DELAY
CJNE A, #0AH, HERE
; 10 number of counts 

CLR TF1
CLR TR1

AGAIN: 
MOV TH0, #0FEH
MOV TL0, #33H
SETB TR0
CPL P1.2
LOOP: JNB TF0, LOOP

CLR TR0
CLR TF0
CLR TR1
CLR TF1

SJMP AGAIN
DELAY: DJNZ R7, DELAY1			
	RET						

DELAY1: DJNZ R6, DELAY2		
	MOV R6, #0FFH			
	SJMP DELAY				

DELAY2: DJNZ R5, DELAY2		
	MOV R5, #0FFH			
	SJMP DELAY1				

; Time delay for R7, R6, R5 to reach 0
; This delay is for count only, timer delay is different

RET
END
