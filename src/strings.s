
.global print_string

# arguments:
# r4 - put the address to start reading here
print_string:
	subi  sp, sp, 8
	stw   r23, 0(sp)
	stw   ra,  4(sp)
	mov   r2, r0                # set counter to 0
	mov   r23, r4               # put the pointer somewhere safe
	movia r4, JTAG_ADDRESS      # load the address argument for poll_write

WRITE_LOOP_print_string:
	ldbu  r5, 0(r23)
	beq   r5, r0, RETURN_print_string  # break if null char
	call  poll_write
	addi  r23, r23, 1            # increment pointer
	addi  r2, r2, 1              # increment counter
	br    WRITE_LOOP_print_string

RETURN_print_string:
	ldw   ra,  4(sp)
	ldw   r23, 0(sp)
	addi  sp, sp, 8

	addi  r2, r2, 1             # push r2 to the next byte
	ret 
