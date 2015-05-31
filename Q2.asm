;   PIC Type:   PIC16F873A
;   Filename:   Q2.asm
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

; each of these will store a different possible user input

user_0000   EQU 0x30
user_0001   EQU 0x31
user_0010   EQU 0x32
user_0011   EQU 0x33
user_0100   EQU 0x34
user_0101   EQU 0x35
user_0110   EQU 0x36
user_0111   EQU 0x37
user_1000   EQU 0x38
user_1001   EQU 0x39
user_1010   EQU 0x40
user_1011   EQU 0x41
user_1100   EQU 0x42
user_1101   EQU 0x43
user_1110   EQU 0x44
user_1111   EQU 0x45

; subroutines store results here

result_f    EQU 0x50
result_g    EQU 0x51

; subroutine arguments and temporary data

sub_arg     EQU 0x52
sub_temp_a  EQU 0x53
sub_temp_b  EQU 0x54
sub_temp_c  EQU 0x55
sub_temp_d  EQU 0x56

; f subroutine lookup data
sub_f_0     EQU 0x60
sub_f_1     EQU 0x61
sub_f_2     EQU 0x62
sub_f_3     EQU 0x63
sub_f_4     EQU 0x64
sub_f_5     EQU 0x65

;**********************************************************************

	ORG     0x000                   ; processor reset vector
	nop			                    ; nop required for icd
  	goto    main                    ; go to beginning of program
main

; remaining code goes here

; initialize user input values
    MOVLW   b'00000000'
    MOVWF   user_0000
    MOVLW   b'00000001'
    MOVWF   user_0001
    MOVLW   b'00000010'
    MOVWF   user_0010
    MOVLW   b'00000011'
    MOVWF   user_0011
    MOVLW   b'00000100'
    MOVWF   user_0100
    MOVLW   b'00000101'
    MOVWF   user_0101
    MOVLW   b'00000110'
    MOVWF   user_0110
    MOVLW   b'00000111'
    MOVWF   user_0111
    MOVLW   b'00001000'
    MOVWF   user_1000
    MOVLW   b'00001001'
    MOVWF   user_1001
    MOVLW   b'00001010'
    MOVWF   user_1010
    MOVLW   b'00001011'
    MOVWF   user_1011
    MOVLW   b'00001100'
    MOVWF   user_1100
    MOVLW   b'00001101'
    MOVWF   user_1101
    MOVLW   b'00001110'
    MOVWF   user_1110
    MOVLW   b'00001111'
    MOVWF   user_1111

; start testing inputs 
    MOVF    user_1001,  0           ; change to any value, will add 1 by 1 later
    MOVWF   sub_arg
    CALL    func_f

; subroutines for each value
func_f:
    ; initialize lookup table
    MOVLW   b'00001010'
    MOVWF   sub_f_0
    MOVLW   b'00001011'
    MOVWF   sub_f_1
    MOVLW   b'00000101'
    MOVWF   sub_f_2
    MOVLW   b'00000110'
    MOVWF   sub_f_3
    MOVLW   b'00000111'
    MOVWF   sub_f_4
    MOVLW   b'00001111'
    MOVWF   sub_f_5
    ; move function argument to W
    MOVF    sub_arg,    0
    ; test W against lookup table
    ANDWF   sub_f_0,    1
    ANDWF   sub_f_1,    1
    ANDWF   sub_f_2,    1
    ANDWF   sub_f_3,    1
    ANDWF   sub_f_4,    1
    ANDWF   sub_f_5,    1
    ; generate result
    CLRW
    IORWF   sub_f_0,    0
    IORWF   sub_f_1,    0
    IORWF   sub_f_2,    0
    IORWF   sub_f_3,    0
    IORWF   sub_f_4,    0
    IORWF   sub_f_5,    0
    ; write result
    MOVWF   result_f
    RETURN

func_g:
    RETURN

	END                             ; directive 'end of program'
