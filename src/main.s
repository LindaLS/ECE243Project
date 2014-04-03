.include "nios_macros.s"
.include "defs.s"
.include "data.s"
.include "readPoll.s"
.include "print_encoding.s"
.include "get_encoding.s"
.include "deflate.s"
.include "inflate.s"

.section .text
.global main
main:

ENCODE_DATA:
	call encode_data

DECODE:	
	subi sp, sp, 4
	stw ra, 0(sp)

	movia r4, COMPRESSED_DATA
	movia r5, COMPRESSED_DATA_LENGTH
	ldw r5, 0(r5)

	call decode_and_print

STOP:
	br STOP;
	
.end
