
.section .text
.global get_encoding

get_encoding:
	movia r5, 'a'
	blt r4, r5, is_a_space
	movia r5, 'z'
	bgt r4, r5, is_a_space

not_a_space:
	subi r5, r4, 'a'
	br load
is_a_space:
	movi r5, SPACE_INDEX

load:
	movia r4, ENCODE_TABLE
	add r5, r5, r5
	add r5, r5, r5
	add r5, r5, r5
	add r4, r4, r5 # structure is 2 words
	ldw r2, 0(r4)
	ldw r3, 4(r4)

	ret
