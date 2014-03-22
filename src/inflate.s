.include "nios_macros.s"
.include "defs.s"

.section .data
.align 2
FILE:
	.skip 65536
	.word 0xdeadbeef
FILENAME_STR:
	.string "Original filename: "

.section .text

.global main
main:
	movia sp, 0x007ffffc       # init stack ptr
	movia r8, FILE

	addi  r8, r8, 10           # offset for file name with no extra parameters

	movia r4, FILENAME_STR
	call  print_string

	mov   r4, r8
	call  print_string         # print the file name

	add   r8, r8, r2           # move stream pointer to next char

STOP:
	br STOP;

.end