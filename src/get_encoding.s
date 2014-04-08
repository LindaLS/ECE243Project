.section .text
.global get_encoding

get_encoding:
	movia r5, 'a'
	blt r4, r5, not_a_letter
	movia r5, 'z'
	bgt r4, r5, not_a_letter

# is_a_letter:
	subi r5, r4, 'a'
	br load

not_a_letter:
	movi r5, '\n' 
	beq r4, r5, is_a_newine # check is newline
	movi r5, SPACE_INDEX # go with space otherwise
	br load
is_a_newine:
	movi r5, NEWLINE_INDEX
	br load

load:
	movia r4, ENCODE_TABLE
	add r5, r5, r5
	add r5, r5, r5
	add r5, r5, r5
	add r4, r4, r5 # structure is 2 words
	ldw r2, 0(r4)
	ldw r3, 4(r4)

	ret
