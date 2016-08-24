ORG 0000H
	LJMP MAIN
	
ORG 0030H
;************************* DELAY00625 *************************;
DELAY00625:
	SETB PSW.4
	SETB PSW.3
	MOV R1,#64
	DELAY00625_LOOP1:
	MOV R2,#61
	DELAY00625_LOOP2:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DJNZ R2,DELAY00625_LOOP2
	DJNZ R1,DELAY00625_LOOP1
	CLR PSW.4
	CLR PSW.3
RET
;*********************************************************;













;************************* DELAY0125 *************************;
DELAY0125:
	SETB PSW.4
	SETB PSW.3
	MOV R1,#34
	DELAY0125_LOOP1:
	MOV R2,#245
	DELAY0125_LOOP2:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DJNZ R2,DELAY0125_LOOP2
	DJNZ R1,DELAY0125_LOOP1
	CLR PSW.4
	CLR PSW.3
RET
;*********************************************************;














;************************* DELAY025 *************************;
DELAY025:
	SETB PSW.4
	SETB PSW.3
	MOV R1,#66
	DELAY025_LOOP1:
	MOV R2,#237
	DELAY025_LOOP2:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DJNZ R2,DELAY025_LOOP2
	DJNZ R1,DELAY025_LOOP1
	CLR PSW.4
	CLR PSW.3
RET
;*********************************************************;
















;************************* DELAY05 *************************;
DELAY05:
	SETB PSW.4
	SETB PSW.3
	MOV R1,#125
	DELAY05_LOOP1:
	MOV R2,#250
	DELAY05_LOOP2:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DJNZ R2,DELAY05_LOOP2
	DJNZ R1,DELAY05_LOOP1
	CLR PSW.4
	CLR PSW.3
RET
;*********************************************************;



















;************************* Delay 1s *************************;
DELAY1:
	SETB PSW.4
	SETB PSW.3
	MOV R1,#250
	DELAY1_LOOP1:
	MOV R2,#250
	DELAY1_LOOP2:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DJNZ R2,DELAY1_LOOP2
	DJNZ R1,DELAY1_LOOP1
	CLR PSW.4
	CLR PSW.3
RET
;************************************************************;







;************************** UART INIT *******************************;
UART_INIT:
	MOV SCON, #010H
RET
;********************************************************************;









;*************************** UART Transmit ***************************;
UART_TRANSMIT:
	MOV SBUF, R0
	TRANSMIT_LOOP: JNB TI, TRANSMIT_LOOP
	CLR TI
	CLR P3.2
	MOV R1, #100
	TRANSMIT_LOOP2: DJNZ R1, TRANSMIT_LOOP2
	SETB P3.2
RET
;********************************************************************;











;************************* Sang Theo Thu Tu *************************;
SANG_THU_TU:
	MOV P1, #0FFH
	MOV P2, #0FFH
	MOV P3, #0FFH
		
	MOV P0, #0FEH
	ACALL DELAY00625
	
	MOV P0, #0FDH
	ACALL DELAY00625
	
	MOV P0, #0FBH
	ACALL DELAY00625
	
	MOV P0, #0F7H
	ACALL DELAY00625
	
	MOV P0, #0EFH
	ACALL DELAY00625
	
	MOV P0, #0DFH
	ACALL DELAY00625
	
	MOV P0, #0BFH
	ACALL DELAY00625
	
	MOV P0, #07FH
	ACALL DELAY00625
	
	MOV P0, #0FFH
	MOV P1, #0FFH
	MOV P3, #0FFH
		
	MOV P2, #0FEH
	ACALL DELAY00625
	
	MOV P2, #0FDH
	ACALL DELAY00625
	
	MOV P2, #0FBH
	ACALL DELAY00625
	
	MOV P2, #0F7H
	ACALL DELAY00625
	
	MOV P2, #0EFH
	ACALL DELAY00625
	
	MOV P2, #0DFH
	ACALL DELAY00625
	
	MOV P2, #0BFH
	ACALL DELAY00625
	
	MOV P2, #07FH
	ACALL DELAY00625
	
	MOV P0, #0FFH
	MOV P1, #0FFH
	MOV P2, #0FFH
	
	MOV P3, #0EFH
	ACALL DELAY00625
	
	MOV P3, #0DFH
	ACALL DELAY00625
	
	MOV P3, #0BFH
	ACALL DELAY00625
	
	MOV P3, #07FH
	ACALL DELAY00625
	
	MOV P0, #0FFH
	MOV P2, #0FFH
	MOV P3, #0FFH
		
	MOV P1, #0FEH
	ACALL DELAY00625
	
	MOV P1, #0FDH
	ACALL DELAY00625
	
	MOV P1, #0FBH
	ACALL DELAY00625
	
	MOV P1, #0F7H
	ACALL DELAY00625
	
	MOV P1, #0EFH
	ACALL DELAY00625
	
	MOV P1, #0DFH
	ACALL DELAY00625
	
	MOV P1, #0BFH
	ACALL DELAY00625
	
	MOV P1, #07FH
	ACALL DELAY00625
	
	
	MOV R0, #07FH
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0BFH
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0DFH
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0EFH
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0F7H
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0FBH
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0FDH
	LCALL UART_TRANSMIT
	LCALL DELAY025
	
	MOV R0, #0FEH
	LCALL UART_TRANSMIT
	LCALL DELAY025
RET
;********************************************************************;





;************************* Sang Het *************************;
SANG_HET:
MOV P0, #0
MOV P1, #0
MOV P2, #0
MOV P3, #0
RET
;************************************************************;




;************************* MAIN *************************;
MAIN:
	;LCALL SANG_THU_TU
	;CPL P1.1
	;LCALL DELAY00625
	LCALL UART_INIT
	LCALL SANG_HET
MAIN_LOOP:
	LCALL SANG_THU_TU
	
	LJMP MAIN_LOOP
;************************************************************;
END