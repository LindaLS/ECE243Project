.global print_string

# arguments:
# r4 - put the address to start reading here
# r5 - length in number of character (0 to stop at null)
print_string:
	subi  sp, sp, 20
	ldw   ra,  0(sp)
	ldw   r23, 4(sp)
	ldw   r16, 8(sp)
	ldw   r17, 12(sp)
	ldw   r18, 16(sp)

	mov   r2, r0                # set counter to 0
	mov   r23, r4               # put the pointer somewhere safe
	movia r4, JTAG_ADDRESS      # load the address argument for poll_write

	beq r6, r0 WRITE_LOOP_PRINT_NULL

# print for a certain length
	mov r16, r6 				#copy length into r6
WRITE_LOOP_PRINT:
	ldbu  r5, 0(r23)
	beq   r16, r0, RETURN_PRINT_STRING  # break if null char
	call  poll_write
	addi  r23, r23, 1            # increment pointer
	addi  r2, r2, 1
	addi  r5, r5, -1         # increment counter
	br    WRITE_LOOP_PRINT

# print stops at null
WRITE_LOOP_PRINT_NULL:
	ldbu  r5, 0(r23)
	beq   r5, r0, RETURN_PRINT_STRING  # break if null char
	call  poll_write
	addi  r23, r23, 1            # increment pointer
	addi  r2, r2, 1              # increment counter
	br    WRITE_LOOP_PRINT_NULL


RETURN_PRINT_STRING:
	ldw   ra,  0(sp)
	ldw   r23, 4(sp)
	ldw   r16, 8(sp)
	ldw   r17, 12(sp)
	ldw   r18, 16(sp)
	addi  sp, sp, 20

	addi  r2, r2, 1             # push r2 to the next byte
	ret 
