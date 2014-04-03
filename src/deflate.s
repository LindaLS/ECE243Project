.section .data
.align 2
UNCOMPRESSED_DATA:
	.string "abcdefghijklmnopqrstuvwxyz "


.section .text

encode_data:

	subi sp, sp, 36
	stw ra,   0(sp)
	stw r16,  4(sp)
	stw r17,  8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)
	stw r21, 24(sp)
	stw r22, 28(sp)
	stw r23, 32(sp)

	movia r16, UNCOMPRESSED_DATA
	movi r22, 0 #r22 is the print buffer
	movi r23, 7 #r23 is the "buffer space avalible"

ENCODE:
	ldbu r17, (r16)
	beq r17, r0, DONE_ENCODE

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

DONE_ENCODE:

	ldw ra,   0(sp)
	ldw r16,  4(sp)
	ldw r17,  8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	ldw r20, 20(sp)
	ldw r21, 24(sp)
	ldw r22, 28(sp)
	ldw r23, 32(sp)
	addi sp, sp, 36

	ret
