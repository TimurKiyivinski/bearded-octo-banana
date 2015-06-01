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

user_0100   EQU 0x30
user_0101   EQU 0x31
user_0110   EQU 0x32
user_0111   EQU 0x33
user_1000   EQU 0x34
user_1001   EQU 0x35
user_1010   EQU 0x36
user_1011   EQU 0x37
user_1100   EQU 0x38
user_1101   EQU 0x39
user_1110   EQU 0x40
user_1111   EQU 0x41

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

; f subroutine lookup data
sub_g_0     EQU 0x70
sub_g_1     EQU 0x71
sub_g_2     EQU 0x72
sub_g_3     EQU 0x73

;**********************************************************************

	ORG     0x000                   ; processor reset vector
	nop			                    ; nop required for icd
  	goto    main                    ; go to beginning of program
main

; remaining code goes here

; initialize user input values
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

; start testing inputs (func_f)
    MOVF    user_0100,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_0101,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_0110,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_0111,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1000,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1001,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1010,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1011,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1100,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1101,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1110,  0
    MOVWF   sub_arg
    CALL    func_f
    MOVF    user_1111,  0
    MOVWF   sub_arg
    CALL    func_f

; start testing inputs (func_g)
    MOVF    user_0100,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_0101,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_0110,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_0111,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1000,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1001,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1010,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1011,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1100,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1101,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1110,  0
    MOVWF   sub_arg
    CALL    func_g
    MOVF    user_1111,  0
    MOVWF   sub_arg
    CALL    func_g

  	goto    main                    ; go to beginning of program
    
; subroutines for each value
func_f:
    ; initialize lookup table
    MOVLW   b'00000101'
    MOVWF   sub_f_0
    MOVLW   b'00000100'
    MOVWF   sub_f_1
    MOVLW   b'00001010'
    MOVWF   sub_f_2
    MOVLW   b'00001001'
    MOVWF   sub_f_3
    MOVLW   b'00001000'
    MOVWF   sub_f_4
    MOVLW   b'00000000'
    MOVWF   sub_f_5
    ; move function argument to W
    MOVF    sub_arg,    0
    ; test W against lookup table
    XORWF   sub_f_0,    1
    INCF    sub_f_0,    1
    BTFSC   sub_f_0,    4
    MOVF    sub_f_0,    0
    MOVWF   result_f
    BTFSC   sub_f_0,    4
    RETURN
    XORWF   sub_f_1,    1
    INCF    sub_f_1,    1
    BTFSC   sub_f_1,    4
    MOVF    sub_f_1,    0
    MOVWF   result_f
    BTFSC   sub_f_1,    4
    RETURN
    XORWF   sub_f_2,    1
    INCF    sub_f_2,    1
    BTFSC   sub_f_2,    4
    MOVF    sub_f_2,    0
    MOVWF   result_f
    BTFSC   sub_f_2,    4
    RETURN
    XORWF   sub_f_3,    1
    INCF    sub_f_3,    1
    BTFSC   sub_f_3,    4
    MOVF    sub_f_3,    0
    MOVWF   result_f
    BTFSC   sub_f_3,    4
    RETURN
    XORWF   sub_f_4,    1
    INCF    sub_f_4,    1
    BTFSC   sub_f_4,    4
    MOVF    sub_f_4,    0
    MOVWF   result_f
    BTFSC   sub_f_4,    4
    RETURN
    XORWF   sub_f_5,    1
    INCF    sub_f_5,    1
    BTFSC   sub_f_5,    4
    MOVF    sub_f_5,    0
    MOVWF   result_f
    BTFSC   sub_f_5,    4
    RETURN
    ; write wrong
    MOVLW   b'00000000'
    MOVWF   result_f
    RETURN

func_g:
    ; initialize lookup table
    MOVLW   b'00001001'
    MOVWF   sub_g_0
    MOVLW   b'00001000'
    MOVWF   sub_g_1
    MOVLW   b'00000100'
    MOVWF   sub_g_2
    MOVLW   b'00000000'
    MOVWF   sub_g_3
    ; move function argument to W
    MOVF    sub_arg,    0
    ; test W against lookup table
    XORWF   sub_g_0,    1
    INCF    sub_g_0,    1
    BTFSC   sub_g_0,    4
    MOVF    sub_g_0,    0
    MOVWF   result_g
    BTFSC   sub_g_0,    4
    RETURN
    XORWF   sub_g_1,    1
    INCF    sub_g_1,    1
    BTFSC   sub_g_1,    4
    MOVF    sub_g_1,    0
    MOVWF   result_g
    BTFSC   sub_g_1,    4
    RETURN
    XORWF   sub_g_2,    1
    INCF    sub_g_2,    1
    BTFSC   sub_g_2,    4
    MOVF    sub_g_2,    0
    MOVWF   result_g
    BTFSC   sub_g_2,    4
    RETURN
    XORWF   sub_g_3,    1
    INCF    sub_g_3,    1
    BTFSC   sub_g_3,    4
    MOVF    sub_g_3,    0
    MOVWF   result_g
    BTFSC   sub_g_3,    4
    RETURN
    ; write wrong
    MOVLW   b'00000000'
    MOVWF   result_g
    RETURN

	END                             ; directive 'end of program'
