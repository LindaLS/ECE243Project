.include "nios_macros.s"
.include "defs.s"
.include "data.s"
.include "readPoll.s"
.include "print_encoding.s"
.include "get_encoding.s"

.section .data
UNCOMPRESSED_DATA:
	.string "babcdefghijklmnopqrstuvwxyz"

.section .text
.global main
main:

	movia r8, UNCOMPRESSED_DATA
ENCODE:
	ldbu r9, (r8)
	beq r9, r0, STOP

	mov r4, r9
	call get_encoding

	mov r4, r2
	mov r5, r3
	call print_encoding

	addi r8, r8, 1

	br ENCODE



STOP:
	br STOP;

.end