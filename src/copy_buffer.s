# r4 dst
# r5 src
# r6 length in bytes - will truncate to word
.section .text
.global .copy_buffer

copy_buffer:
	srli r6, r6, 2

COPY_BUFFER:
	beq r6, r0, FINISH_COPY_BUFFER

	# copy
	ldw r8, (r5)
	stw r8, (r4)

	addi r4, r4, 4
	addi r5, r5, 4
	addi r6, r6, -1

	br COPY_BUFFER


FINISH_COPY_BUFFER:
	ret
