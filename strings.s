.include "defs.s"

.global print_string

# arguments:
# r4 - put the address to start reading here
print_string:
	subi  sp, sp, 8
	stw   r22, 0(sp)
	stw   r23, 4(sp)
	mov   r2, r0                # set counter to 0
	mov   r23, r4               # put the pointer somewhere safe
	movia r4, JTAG_ADDRESS      # load the address argument for poll_write

WRITE_LOOP_print_string:
	ldbu  r22, 0(r23)
	beq   r22, r0, RETURN_print_string  # break if null char
	call  poll_write
	addi  r23, r23, 1            # increment pointer
	addi  r2, r2, 1              # increment counter
	br    WRITE_LOOP_print_string

RETURN_print_string:
	ldw   r22, 0(sp)
	ldw   r23, 4(sp)
	addi  sp, sp, 8

	addi  r2, r2, 1             # push r2 to the next byte
	ret 
