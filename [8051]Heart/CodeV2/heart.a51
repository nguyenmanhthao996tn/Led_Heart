ORG 0000H
	AJMP MAIN

ORG 000BH
	AJMP TIMER0_HANDLER
	
ORG 0013H
	AJMP EXINT1_HANDLER
	
ORG 001BH
	AJMP TIMER1_HANDLER
	
ORG 0030H
	
	
; ******************** EXTERNAL INTERRUPT 1 INIT & HANDLER ******************** ;
EXINT1_INIT:
SETB IE1 ; EXTERNAL INTERRUPT 1 ENABLE
SETB IT1 ; FALLING EDGE ON INT1 GENERATES INTERRUPT
SETB EX1 ; EXTERNAL ENABLE
SETB EA  ; GLOBAL INTERRUPT ENABLE
RET




EXINT1_HANDLER:
ACALL TURN_ON_ALL
RETI
; ***************************************************************************** ;





; ***************************** TIMER 0 INIT & HANDLER ***************************** ;
TIMER0_INIT:
ORL TMOD, #001H 			; MODE 1
MOV TL0, #0DBH
MOV TH0, #00BH				; 3035 = 0.0625s
SETB ET0 					; ENABLE INTERRUPT FOR TC0
SETB EA  					; ENABLE GLOBAL INTERRUPT
SETB TR0 					; ALLOW TC0 TO RUN
RET

TIMER0_HANDLER:
MOV TL0, #0DH
MOV TH0, #00BH				; RELOAD VALUE
CPL P0.0
RETI
; ********************************************************************************** ;



; ***************************** TIMER 1 INIT & HANDLER ***************************** ;
TIMER1_INIT:
ORL TMOD, #010H 			; MODE 1
MOV TL1, #0EFH
MOV TH1, #0D8H				; 55535 = 10ms
SETB ET1 					; ENABLE INTERRUPT FOR TC1
SETB EA  					; ENABLE GLOBAL INTERRUPT
SETB TR1 					; ALLOW TC1 TO RUN
RET

TIMER1_HANDLER:
MOV TL1, #0EFH
MOV TH1, #0D8H						; RELOAD VALUE
CJNE R7, #0, TIMER1_HANDLER_DEC 	; IF R7 != 0 THEN DECREASE R7
RETI
TIMER1_HANDLER_DEC:
DEC R7								; R7 = R7 - 1
RETI
; ********************************************************************************** ;



; ***************************** UART ***************************** ;
UART_INIT:
	MOV SCON, #010H
RET


UART_TRANSMIT:
	MOV SBUF, R0
	TRANSMIT_LOOP: JNB TI, TRANSMIT_LOOP
	CLR TI
	CLR P3.2
	MOV R1, #100
	TRANSMIT_LOOP2: DJNZ R1, TRANSMIT_LOOP2
	SETB P3.2
RET
; **************************************************************** ;



; ************************************* DELAY *************************************** ;
DELAY:
MOV R7, A ; R7 = R6
DELAY_LOOP: CJNE R7, #0, DELAY_LOOP ; IF R7 != 0 -> LOOP
RET
; *********************************************************************************** ;


; ************************************* FUNCTION ************************************* ;
TURN_OFF_ALL:
MOV P0, #0FFH
MOV P1, #0FFH
MOV P2, #0FFH
MOV P3, #0FFH

MOV R0, #0FFH
ACALL UART_TRANSMIT
RET

TURN_ON_ALL:
MOV P0, #0
MOV P1, #0
MOV P2, #0
MOV P3, #00FH

MOV R0, #000H
ACALL UART_TRANSMIT
RET
; *********************************************************************************** ;


; ******************************* MAIN FUNTION ******************************* ;
	MAIN:
	;ACALL EXINT1_INIT 		; INITIAL EXTERNAL INTERRUPT 1
	;ACALL UART_INIT 		; INITIAL UART FOR 74HC595
	;ACALL TIMER0_INIT		; INITIAL TIMER0
	ACALL TIMER1_INIT		; INITIAL TIMER1
	;ACALL TURN_OFF_ALL 		; TURN OFF ALL LED
	
	MAIN_LOOP:
	MOV A, 100
	ACALL DELAY
	CPL P0.0
	AJMP MAIN_LOOP
; **************************************************************************** ;



; ************************************* EFFECTS ************************************* ;

; *********************************************************************************** ;


END