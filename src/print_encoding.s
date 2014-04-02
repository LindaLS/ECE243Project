.section .text
.global print_encoding

# parameters
# r4 - length
# r5 - encoding
print_encoding:
	subi sp, sp, 16
	stw ra,  0(sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r18, 12(sp)

	mov r17, r5	    # save the encoding somewhere safe
	mov r18, r4     # save the length somewhere safe

	movi r16, 32
	sub r16, r16, r18 #r16 now holds the number of character before the encoding begins

	sll r17, r17, r16 #r17 now has the encoding at the most left

PRINT:
	beq r18, r0, DONE
	andi r16, r17, 0x8000 #mask out everything but the first bit
	movia r4, JTAG_ADDRESS
	beq r16, r0, PRINT_0:

	movi r5, '1'
	br actually_print
PRINT_0:
	movi r5, '0'

actually_print:
	call poll_write

	subi r18, r18, 1
	slli r17, r17, 1
	br PRINT

DONE :
	ldw ra,  0(sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r18, 12(sp)
	addi sp, sp, 16
	ret