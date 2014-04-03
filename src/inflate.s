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

	movia r16, UNCOMPRESSED_DATA
	movi r22, 0 #r22 is the print buffer
	movi r23, 7 #r23 is the "buffer space avalible"

ENCODE:
	ldbu r17, (r16)
	beq r17, r0, STOP

	mov r4, r17

	#r4 character, r2 length, r3 encoding
	call get_encoding

	#move value to most left
	movi r18, 32
	sub r18, r18, r2
	sll r19, r3, r18

	#r18 holds 32 - length, r19 holds value
SEND_TO_BUFFER:
	andi r20, r19, 0x80000000
	srli r20, r20, 31
	#r20 now holds the bit at the right most bit

	sll r20, r20, r23 #shift to next avalible buffer space
	or r22, r22, r20
	bne r23, r0, SKIP_PRINT
PRINT_BUFFER:
	movia r4, JTAG_ADDRESS
	mov r5, r22
	call poll_write
	movi r23, 8
	mov r22, r0
SKIP_PRINT:
	subi r23, r23, 1
	subi r2, r2, 1
	slli r19, r19, 1
	bne r2, r0, SEND_TO_BUFFER

	# mov r4, r2
	# mov r5, r3
	# call print_encoding

	addi r16, r16, 1

	br ENCODE

	movia r4, JTAG_ADDRESS
	mov r5, r22
	call poll_write


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
