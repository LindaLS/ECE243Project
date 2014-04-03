.include "nios_macros.s"
.include "defs.s"
.include "data.s"
.include "readPoll.s"
.include "print_encoding.s"
.include "get_encoding.s"
.include "deflate.s"

.section .data
UNCOMPRESSED_DATA:
	.string "abcdefghijklmnopqrstuvwxyz "

.align 2
COMPRESSED_DATA:
	       #0123456789ABCDEF0123456789ABCDEF
	.word 0b00000000110001111100001100100101
	.word 0b11000111100110001110101100011010
	.word 0b11001000010010101011010001000011
	.word 0b01010110000101110011000100011110
	.word 0b01011010101000101100010000111001
	.word 0b01100000111111111111111111111111
	      #last one ^

.align 2
COMPRESSED_DATA_LENGTH:
	.word 169

.section .text
.global main
main:
	# br DECODE ##### uncomment me to test decoding code
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


DECODE:	
	subi sp, sp, 4
	stw ra, 0(sp)

	movia r4, COMPRESSED_DATA
	movia r5, COMPRESSED_DATA_LENGTH
	ldw r5, 0(r5)

	call decode_and_print
	
	ldw ra, 0(sp)
	addi sp, sp, 4
	br STOP

.end
