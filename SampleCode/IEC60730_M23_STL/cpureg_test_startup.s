; ____  _____             ____    ____    _                                 ______    _________   ____  _     *
; |_   \|_   _|           |_   \  /   _|  (_)                              .' ____ \  |  _   _  | |_   _|     *
;   |   \ | |    __   _     |   \/   |    __    .---.   _ .--.    .--.     | (___ \_| |_/ | | \_|   | |       *
;   | |\ \| |   [  | | |    | |\  /| |   [  |  / /'`\] [ `/'`\] / .'`\ \    _.____`.      | |       | |   _   *
;  _| |_\   |_   | \_/ |,  _| |_\/_| |_   | |  | \__.   | |     | \__. |   | \____) |    _| |_     _| |__/ |  *
; |_____|\____|  '.__.'_/ |_____||_____| [___] '.___.' [___]     '.__.'     \______.'   |_____|   |________|  *
;                                                                                                             *
; @file     cpureg_test_startup.s                                                                             *
; @version  V1.00                                                                                             *
; $Date: 3/10/21 4:11p $                                                                                     *
; @brief    IIEC60730 CPU Register Test Startup Time                                                          *
; @note                                                                                                       *
; SPDX-License-Identifier: Apache-2.0                                                                         *
; @copyright (C) 2016-2020 Nuvoton Technology Corp. All rights reserved.                                      *
;**************************************************************************************************************
	AREA    |.text|, CODE, READONLY
	EXPORT	IEC60730_CPU_Reg_Test
	
pattern1 	EQU		0x55555555
pattern2 	EQU		0xAAAAAAAA

IEC60730_CPU_Reg_Test
;push registers to stack
	push	{r1-r7}

;===========R0 Test=============
;R0 test
;compare bit 0-7
	movs	r0, #0xAA
	cmp		r0, #0xAA
	bne     _test_r0_fail
	movs	r0, #0x55
	cmp		r0, #0x55				;For SW test breakpoint
	bne     _test_r0_fail

;compare bit 8-15
	ldr		r0, =0x0000AA00
	lsrs    r0, r0, #8	
	cmp		r0, #0xAA
	bne     _test_r0_fail	
	ldr		r0, =0x00005500
	lsrs    r0, r0, #8	
	cmp		r0, #0x55
	bne     _test_r0_fail

;compare bit 16-23	
	ldr		r0, =0x00AA0000
	lsrs    r0, r0, #16	
	cmp		r0, #0xAA
	bne     _test_r0_fail	
	ldr		r0, =0x00550000
	lsrs    r0, r0, #16	
	cmp		r0, #0x55
	bne     _test_r0_fail

;compare bit 24-31
	ldr		r0, =0xAA000000
	lsrs    r0, r0, #24	
	cmp		r0, #0xAA
	bne     _test_r0_fail	
	ldr		r0, =0x55000000
	lsrs    r0, r0, #24	
	cmp		r0, #0x55
	bne     _test_r0_fail

;pass
	b		_reg_test_r1_r7
	
_test_r0_fail
;enable interrupt
	movs    r0, #0
	msr     PRIMASK, r0
	
;restore registers
    pop     {r1-r7}

;Branch back
	bx      lr
;===================================

;===========R1 - R7 Test=============
_reg_test_r1_r7
	ldr		r1, =pattern1
	ldr     r0, =pattern1 
	cmp		r1, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r1, =pattern2
	ldr     r0, =pattern2
	cmp		r1, r0				
	bne 	_test_r1_r7_fail
	
    ldr		r2, =pattern1
	ldr     r0, =pattern1 
	cmp		r2, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r2, =pattern2
	ldr     r0, =pattern2
	cmp		r2, r0
	bne 	_test_r1_r7_fail
	
	ldr		r3, =pattern1
	ldr     r0, =pattern1 
	cmp		r3, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r3, =pattern2
	ldr     r0, =pattern2
	cmp		r3, r0
	bne 	_test_r1_r7_fail
	
	ldr		r4, =pattern1
	ldr     r0, =pattern1 
	cmp		r4, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r4, =pattern2
	ldr     r0, =pattern2
	cmp		r4, r0
	bne 	_test_r1_r7_fail
	
	ldr		r5, =pattern1
	ldr     r0, =pattern1 
	cmp		r5, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r5, =pattern2
	ldr     r0, =pattern2
	cmp		r5, r0
	bne 	_test_r1_r7_fail
	
	ldr		r6, =pattern1
	ldr     r0, =pattern1 
	cmp		r6, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r6, =pattern2
	ldr     r0, =pattern2
	cmp		r6, r0
	bne 	_test_r1_r7_fail
	
	ldr		r7, =pattern1
	ldr     r0, =pattern1 
	cmp		r7, r0				;For SW test breakpoint
	bne 	_test_r1_r7_fail
	ldr		r7, =pattern2
	ldr     r0, =pattern2
	cmp		r7, r0
	bne 	_test_r1_r7_fail
	
	b		_reg_test_r8_r12
	
_test_r1_r7_fail
;enable interrupt
	movs    r0, #0
	msr     PRIMASK, r0
	
;restore registers
    pop     {r1-r7}

;Branch back
	bx      lr
;===================================

;===========R8 - R12 Test============
_reg_test_r8_r12
;store r8-r12
	mov		r3, r8
	mov 	r4, r9
	mov 	r5, r10
	mov 	r6, r11
	mov 	r7, r12

	ldr     r0, =pattern1
	mov     r8, r0
	cmp		r8, r0				;For SW test breakpoint
	bne 	_test_r8_r12_fail
    ldr     r0, =pattern2
	mov     r8, r0
	cmp		r8, r0
	bne 	_test_r8_r12_fail
	
	ldr     r0, =pattern1
	mov     r9, r0
	cmp		r9, r0				;For SW test breakpoint
	bne 	_test_r8_r12_fail
	ldr     r0, =pattern2
	mov     r9, r0
	cmp		r9, r0
	bne 	_test_r8_r12_fail

	ldr     r0, =pattern1
	mov     r10, r0
	cmp		r10, r0				;For SW test breakpoint
	bne 	_test_r8_r12_fail
	ldr     r0, =pattern2
	mov     r10, r0
	cmp		r10, r0
	bne 	_test_r8_r12_fail
	
	ldr     r0, =pattern1
	mov     r11, r0
	cmp		r11, r0				;For SW test breakpoint
	bne 	_test_r8_r12_fail
	ldr     r0, =pattern2
	mov     r11, r0
	cmp		r11, r0
	bne 	_test_r8_r12_fail
	
	ldr     r0, =pattern1
	mov     r12, r0
	cmp		r12, r0				;For SW test breakpoint
	bne 	_test_r8_r12_fail
	ldr     r0, =pattern2
	mov     r12, r0
	cmp		r12, r0
	bne 	_test_r8_r12_fail
	
;restore r8-r12		
	mov 	r12, r7
	mov 	r11, r6
	mov 	r10, r5
	mov 	r9, r4
	mov 	r8, r3
	
	b		_reg_test_PRIMASK
		
_test_r8_r12_fail
;enable interrupt
	movs    r0, #0
	msr     PRIMASK, r0

;restore registers	
    pop     {r1-r7}
    			
;restore r8-r12		
	mov 	r12, r7
	mov 	r11, r6
	mov 	r10, r5
	mov 	r9, r4
	mov 	r8, r3

;Branch back
	bx      lr
;===================================

;===========PRIMASK Test=============
; Only one bit can be tested

_reg_test_PRIMASK		
	mrs		r0, PRIMASK
	
	movs	r1, #0x0
	msr 	PRIMASK, r1
	mrs		r2, PRIMASK				;For SW test breakpoint
	cmp		r2, r1
	bne		_test_primask_fail
	
	movs	r1, #0x1
	msr 	PRIMASK, r1
	mrs		r2, PRIMASK
	cmp		r2, r1
	bne		_test_primask_fail
	
	msr 	PRIMASK, r0
	
	b		_reg_test_CONTROL
	
_test_primask_fail
;enable interrupt
	movs    r0, #0
	msr     PRIMASK, r0
	
;restore registers
	pop     {r1-r7}
		
;Branch back
	bx      lr
;=================================== 	

;===========CONTROL Test=============
; Only one bit can be tested

_reg_test_CONTROL		
	mrs		r0, CONTROL
	
	movs	r1, #0x0
	msr 	CONTROL, r1
	mrs		r2, CONTROL				;For SW test breakpoint
	cmp		r2, r1
	bne		_test_control_fail
	
	movs	r1, #0x2
	msr 	CONTROL, r1
	mrs		r2, CONTROL
	cmp		r2, r1
	bne		_test_control_fail
	
	msr 	CONTROL, r0
	
	b		_reg_test_SP
	
_test_control_fail
;enable interrupt
	movs    r0, #0                  
	msr     PRIMASK, r0
	
;restore registers
	pop     {r1-r7}
		
;Branch back
	bx      lr
;===================================

;===========SP Test=============
_reg_test_SP
;disable interrupt	
;	movs    r0, #0x01
;    msr     PRIMASK, r0

;store CONTROL	
	mrs     r0, CONTROL

;store MSP
	mov     r3, r13
				
	movs    r2, #0x00
    msr     CONTROL, r2

;compare r13 & MSP    
    mrs     r1, MSP
    cmp		r1, r3             
    bne 	_test_sp_fail
	
;r13 & MSP are the same
	ldr		r1, =0xAAAAAAA8
	mov		r13, r1
	cmp		r13, r1				;For SW test breakpoint
	bne 	_test_sp_fail
	
	ldr		r1, =0x55555554
	mov		r13, r1
	cmp		r13, r1
	bne 	_test_sp_fail
	
;enable interrupt
	movs    r0, #0x00
    msr     PRIMASK, r0

;restore CONTROL    
	msr		CONTROL, r0

;restore MSP
	mov     r13, r3
		
	b 		_reg_test_LR
	
_test_sp_fail
;restore registers
    mov     r13, r3
	pop     {r1-r7}
	msr		CONTROL, r0
	movs    r0, #0x00
	
;Branch back
	bx      lr
;=================================== 

;===========LR Test=============	
_reg_test_LR
	mov		r0, r14
	
	ldr		r1, =0x55555555
	mov 	r14, r1
	cmp		r14, r1				;For SW test breakpoint
	bne		_test_lr_fail
	
	ldr		r1, =0xAAAAAAAA
	mov 	r14, r1
	cmp		r14, r1
	bne		_test_lr_fail
	
	mov 	r14, r0
	
	b		_reg_test_APSR
	
_test_lr_fail
;enable interrupt
    mov     r14, r0
	movs    r0, #0
	msr     PRIMASK, r0
	
;restore registers
	pop     {r1-r7}
		
;Branch back
	bx      lr
;=================================== 	

;===========APSR Test=============	
_reg_test_APSR	
	mrs		r0, APSR
	
	ldr		r1, =0xA0000000
	msr 	APSR, r1
	mrs		r2, APSR				;For SW test breakpoint
	cmp		r2, r1
	bne		_test_apsr_fail
	
	ldr		r1, =0x50000000
	msr 	APSR, r1
	mrs		r2, APSR
	cmp		r2, r1
	bne		_test_apsr_fail
	
	msr 	APSR, r0
	
	b		_test_cpu_reg_pass
	
_test_apsr_fail
;restore registers
	pop     {r1-r7}
	movs    r0, #0x00
		
;Branch back
	bx      lr
;=================================== 	


_test_cpu_reg_pass
;enable interrupt
	movs    r0, #0
	msr     PRIMASK, r0
	
;restore registers
	pop     {r1-r7}
	movs    r0, #1
		
;Branch back
	bx      lr
	NOP
    NOP	
	END