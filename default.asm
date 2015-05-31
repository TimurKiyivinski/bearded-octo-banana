;   PIC Type:   PIC16F873A
;   Filename:   default.asm
;   Author:     
;

	list		p=16f873A	        ; list directive to define processor
	#include	<p16f873A.inc>	    ; processor specific variable definitions
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF

;***** VARIABLE DEFINITIONS
w_temp		EQU	0x20		        ; variable used for context saving
w_temp1		EQU	0xA0		        ; reserve bank1 equivalent of w_temp 
status_temp	EQU	0x21		        ; variable used for context saving
pclath_temp	EQU	0x22		        ; variable used for context saving

;**********************************************************************

	ORG     0x000                   ; processor reset vector
	nop			                    ; nop required for icd
  	goto    main                    ; go to beginning of program
main

; remaining code goes here

	END                             ; directive 'end of program'
