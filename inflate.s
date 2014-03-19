.include "nios_macros.s"
.equ JTAG_ADDRESS, 0x10001000

.section .data
.align 2
FILE:
	.skip 65536
	.word 0xdeadbeef

.section .text

.global main
main:

	movia r8, FILE

	addi r8, r8, 40            #offset for file name with no extra parameters

GET_FILE_NAME:
	movia r4, JTAG_ADDRESS

LOOP_READ_NAME:
	ldw r5, 0(r8)
	beq r5, r0, END_READ_NAME
	call poll_write
	addi r8, r8, 4
	br LOOP_READ_NAME

END_READ_NAME:
	br END_READ_NAME;

.end