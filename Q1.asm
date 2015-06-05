
;   PIC Type:   PIC16F873A
;   Filename:   Q1.asm
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
user_0000   EQU 0x26
user_0001   EQU 0x27
user_0010   EQU 0x28
user_0011   EQU 0x29
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

result_w    EQU 0x42
result_x    EQU 0x43
result_y    EQU 0x44
result_z    EQU 0x45

; subroutine arguments and temporary data

sub_arg     EQU 0x46
sub_temp_a  EQU 0x47 
sub_temp_b  EQU 0x48
sub_temp_c  EQU 0x49
sub_temp_d  EQU 0x50

; w subroutine lookup data
sub_w_0     EQU 0x51
sub_w_1     EQU 0x52
sub_w_2     EQU 0x53
sub_w_3     EQU 0x54
sub_w_4     EQU 0x55
sub_w_5     EQU 0x56
sub_w_6     EQU 0x57
sub_w_7     EQU 0x58

; x subroutine lookup data
sub_x_0     EQU 0x59
sub_x_1     EQU 0x60
sub_x_2     EQU 0x61
sub_x_3     EQU 0x62
sub_x_4     EQU 0x63
sub_x_5     EQU 0x64
sub_x_6     EQU 0x65

; y subroutine lookup data
sub_y_0     EQU 0x66
sub_y_1     EQU 0x67
sub_y_2     EQU 0x68
sub_y_3     EQU 0x69
sub_y_4     EQU 0x70
sub_y_5     EQU 0x71

; z subroutine lookup data
sub_z_0     EQU 0x72
sub_z_1     EQU 0x73
sub_z_2     EQU 0x74

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

; inputs return 00010000 if true, 00000000 if false
; all functions use a lookup table technique to compare values
; true values will result in 00001111 in the lookup table, and thus
; an incrememt of this value will be 00010000
; by testing the 4th bit if set, the functions can return true or 
; continue and return a reset value of false

; start testing inputs (func_w)
    MOVF    user_0000,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0001,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0010,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0011,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0100,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0101,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0110,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_0111,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1000,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1001,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1010,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1011,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1100,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1101,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1110,  0
    MOVWF   sub_arg
    CALL    func_w
    MOVF    user_1111,  0
    MOVWF   sub_arg
    CALL    func_w

; start testing inputs (func_x)
    MOVF    user_0000,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0001,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0010,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0011,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0100,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0101,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0110,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_0111,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1000,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1001,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1010,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1011,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1100,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1101,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1110,  0
    MOVWF   sub_arg
    CALL    func_x
    MOVF    user_1111,  0
    MOVWF   sub_arg
    CALL    func_x

; start testing inputs (func_y)
    MOVF    user_0000,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0001,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0010,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0011,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0100,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0101,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0110,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_0111,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1000,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1001,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1010,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1011,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1100,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1101,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1110,  0
    MOVWF   sub_arg
    CALL    func_y
    MOVF    user_1111,  0
    MOVWF   sub_arg
    CALL    func_y

; start testing inputs (func_z)
    MOVF    user_0000,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0001,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0010,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0011,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0100,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0101,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0110,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_0111,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1000,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1001,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1010,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1011,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1100,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1101,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1110,  0
    MOVWF   sub_arg
    CALL    func_z
    MOVF    user_1111,  0
    MOVWF   sub_arg
    CALL    func_z

  	goto    main                    ; go to beginning of program
    
; subroutines for each value
func_w:
    ; initialize lookup table
    MOVLW   b'00001101'
    MOVWF   sub_w_0
    MOVLW   b'00001100'
    MOVWF   sub_w_1
    MOVLW   b'00001011'
    MOVWF   sub_w_2
    MOVLW   b'00000111'
    MOVWF   sub_w_3
    MOVLW   b'00000110'
    MOVWF   sub_w_4
    MOVLW   b'00000101'
    MOVWF   sub_w_5
    MOVLW   b'00000001'
    MOVWF   sub_w_6
    MOVLW   b'00000000'
    MOVWF   sub_w_7
    ; move function argument to w
    MOVF    sub_arg,    0
    ; test w against lookup table
    XORWF   sub_w_0,    1
    INCF    sub_w_0,    1
    BTFSC   sub_w_0,    4
    MOVF    sub_w_0,    0
    MOVWF   result_w
    BTFSC   sub_w_0,    4
    RETURN
    XORWF   sub_w_1,    1
    INCF    sub_w_1,    1
    BTFSC   sub_w_1,    4
    MOVF    sub_w_1,    0
    MOVWF   result_w
    BTFSC   sub_w_1,    4
    RETURN
    XORWF   sub_w_2,    1
    INCF    sub_w_2,    1
    BTFSC   sub_w_2,    4
    MOVF    sub_w_2,    0
    MOVWF   result_w
    BTFSC   sub_w_2,    4
    RETURN
    XORWF   sub_w_3,    1
    INCF    sub_w_3,    1
    BTFSC   sub_w_3,    4
    MOVF    sub_w_3,    0
    MOVWF   result_w
    BTFSC   sub_w_3,    4
    RETURN
    XORWF   sub_w_4,    1
    INCF    sub_w_4,    1
    BTFSC   sub_w_4,    4
    MOVF    sub_w_4,    0
    MOVWF   result_w
    BTFSC   sub_w_4,    4
    RETURN
    XORWF   sub_w_5,    1
    INCF    sub_w_5,    1
    BTFSC   sub_w_5,    4
    MOVF    sub_w_5,    0
    MOVWF   result_w
    BTFSC   sub_w_5,    4
    RETURN
    XORWF   sub_w_6,    1
    INCF    sub_w_6,    1
    BTFSC   sub_w_6,    4
    MOVF    sub_w_6,    0
    MOVWF   result_w
    BTFSC   sub_w_6,    4
    RETURN
    XORWF   sub_w_7,    1
    INCF    sub_w_7,    1
    BTFSC   sub_w_7,    4
    MOVF    sub_w_7,    0
    MOVWF   result_w
    BTFSC   sub_w_7,    4
    RETURN
    ; write wrong
    MOVLW   b'00000000'
    MOVWF   result_w
    RETURN

func_x:
    ; initialize lookup table
    MOVLW   b'00001110'
    MOVWF   sub_x_0
    MOVLW   b'00001010'
    MOVWF   sub_x_1
    MOVLW   b'00001101'
    MOVWF   sub_x_2
    MOVLW   b'00001100'
    MOVWF   sub_x_3
    MOVLW   b'00001000'
    MOVWF   sub_x_4
    MOVLW   b'00000100'
    MOVWF   sub_x_5
    MOVLW   b'00000010'
    MOVWF   sub_x_6
    ; move function argument to x
    MOVF    sub_arg,    0
    ; test W against lookup table
    XORWF   sub_x_0,    1
    INCF    sub_x_0,    1
    BTFSC   sub_x_0,    4
    MOVF    sub_x_0,    0
    MOVWF   result_x
    BTFSC   sub_x_0,    4
    RETURN
    XORWF   sub_x_1,    1
    INCF    sub_x_1,    1
    BTFSC   sub_x_1,    4
    MOVF    sub_x_1,    0
    MOVWF   result_x
    BTFSC   sub_x_1,    4
    RETURN
    XORWF   sub_x_2,    1
    INCF    sub_x_2,    1
    BTFSC   sub_x_2,    4
    MOVF    sub_x_2,    0
    MOVWF   result_x
    BTFSC   sub_x_2,    4
    RETURN
    XORWF   sub_x_3,    1
    INCF    sub_x_3,    1
    BTFSC   sub_x_3,    4
    MOVF    sub_x_3,    0
    MOVWF   result_x
    BTFSC   sub_x_3,    4
    RETURN
    XORWF   sub_x_4,    1
    INCF    sub_x_4,    1
    BTFSC   sub_x_4,    4
    MOVF    sub_x_4,    0
    MOVWF   result_x
    BTFSC   sub_x_4,    4
    RETURN
    XORWF   sub_x_5,    1
    INCF    sub_x_5,    1
    BTFSC   sub_x_5,    4
    MOVF    sub_x_5,    0
    MOVWF   result_x
    BTFSC   sub_x_5,    4
    RETURN
    XORWF   sub_x_6,    1
    INCF    sub_x_6,    1
    BTFSC   sub_x_6,    4
    MOVF    sub_x_6,    0
    MOVWF   result_x
    BTFSC   sub_x_6,    4
    RETURN
    ; write wrong
    MOVLW   b'00000000'
    MOVWF   result_x
    RETURN

func_y:
    ; initialize lookup table
    MOVLW   b'00001101'
    MOVWF   sub_y_0
    MOVLW   b'00001100'
    MOVWF   sub_y_1
    MOVLW   b'00001000'
    MOVWF   sub_y_2
    MOVLW   b'00000111'
    MOVWF   sub_y_3
    MOVLW   b'00000011'
    MOVWF   sub_y_4
    MOVLW   b'00000010'
    MOVWF   sub_y_5
    ; move function argument to y
    MOVF    sub_arg,    0
    ; test W against lookup table
    XORWF   sub_y_0,    1
    INCF    sub_y_0,    1
    BTFSC   sub_y_0,    4
    MOVF    sub_y_0,    0
    MOVWF   result_y
    BTFSC   sub_y_0,    4
    RETURN
    XORWF   sub_y_1,    1
    INCF    sub_y_1,    1
    BTFSC   sub_y_1,    4
    MOVF    sub_y_1,    0
    MOVWF   result_y
    BTFSC   sub_y_1,    4
    RETURN
    XORWF   sub_y_2,    1
    INCF    sub_y_2,    1
    BTFSC   sub_y_2,    4
    MOVF    sub_y_2,    0
    MOVWF   result_y
    BTFSC   sub_y_2,    4
    RETURN
    XORWF   sub_y_3,    1
    INCF    sub_y_3,    1
    BTFSC   sub_y_3,    4
    MOVF    sub_y_3,    0
    MOVWF   result_y
    BTFSC   sub_y_3,    4
    RETURN
    XORWF   sub_y_4,    1
    INCF    sub_y_4,    1
    BTFSC   sub_y_4,    4
    MOVF    sub_y_4,    0
    MOVWF   result_y
    BTFSC   sub_y_4,    4
    RETURN
    XORWF   sub_y_5,    1
    INCF    sub_y_5,    1
    BTFSC   sub_y_5,    4
    MOVF    sub_y_5,    0
    MOVWF   result_y
    BTFSC   sub_y_5,    4
    RETURN
    ; write wrong
    MOVLW   b'00000000'
    MOVWF   result_y
    RETURN

func_z:
    ; initialize lookup table
    MOVLW   b'00001011'
    MOVWF   sub_z_0
    MOVLW   b'00001000'
    MOVWF   sub_z_1
    MOVLW   b'00000011'
    MOVWF   sub_z_2
    ; move function argument to z
    MOVF    sub_arg,    0
    ; test W against lookup table
    XORWF   sub_z_0,    1
    INCF    sub_z_0,    1
    BTFSC   sub_z_0,    4
    MOVF    sub_z_0,    0
    MOVWF   result_z
    BTFSC   sub_z_0,    4
    RETURN
    XORWF   sub_z_1,    1
    INCF    sub_z_1,    1
    BTFSC   sub_z_1,    4
    MOVF    sub_z_1,    0
    MOVWF   result_z
    BTFSC   sub_z_1,    4
    RETURN
    XORWF   sub_z_2,    1
    INCF    sub_z_2,    1
    BTFSC   sub_z_2,    4
    MOVF    sub_z_2,    0
    MOVWF   result_z
    BTFSC   sub_z_2,    4
    RETURN
    ; write wrong
    MOVLW   b'00000000'
    MOVWF   result_z
    RETURN

	END                             ; directive 'end of program'
