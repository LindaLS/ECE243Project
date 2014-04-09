# r4 dst
# r5 src
# r6 length in bytes - will truncate to word
.section .text
.global copy_buffer
.global set_buffer

copy_buffer:
	srli r6, r6, 2

COPY_BUFFER:
	beq r6, r0, FINISH_COPY_BUFFER

	# copy
	ldwio r8, (r5)
	stwio r8, (r4)

	addi r4, r4, 4
	addi r5, r5, 4
	addi r6, r6, -1

	br COPY_BUFFER
FINISH_COPY_BUFFER:
	ret

# r4 src
# r5 word to set
# r6 length in bytes - will truncate to word
set_buffer:
	srli r6, r6, 2

SET_BUFFER:
	beq r6, r0, FINISH_SET_BUFFER

	# copy
	stwio r5, (r4)

	addi r4, r4, 4
	addi r6, r6, -1

	br SET_BUFFER	

FINISH_SET_BUFFER:
	ret
