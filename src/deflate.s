.section .text
.global decode_and_print

# params
# r4 - ptr to data to read
# r5 - max number of bytes to read here

decode_and_print:
	subi sp, sp, 24
	stw ra,   0(sp)
	stw r16,  4(sp)
	stw r17,  8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)

	mov r16, r4
	mov r17, r5
	movia r20, HUFF_TREE

decode_loop:

	ldw r18, 0(r16) # load word at ptr
	movia r19, 0x80000000 # init word bit mask

	decode_word_loop:
		blt r17, r0, end_decode # break if no bits left
		beq r19, r0, end_decode_word_loop # break word loop if the word bit mask has been shifted out

		#	if (treeptr.char == 0) {
		#		if (bit == 0) {
		#			treeptr = *(treeptr + 4);
		#		} else {
		#			treeptr = *(treeptr + 8);
		#		}
		#	} else {
		#		print(treeptr.char)
		#		treeptr = ROOT;
		#	}

		ldw r5, 0(r20) # load treeptr.char (has to be r5 - param to poll_write)
		bne r5, r0, print_char # if not 0, print it
		
		and r5, r18, r19 # mask out bit
		bne r5, r0, go_right # if not 0 go right

		go_left:
			ldw r20, 4(r20) # treeptr = *(treeptr + 4)
			br dont_print
		go_right:
			ldw r20, 8(r20) # treeptr = *(treeptr + 8)
			br dont_print

		print_char:
			movia r4, JTAG_ADDRESS
			call poll_write # print the char
			movia r20, HUFF_TREE # reset ptr
			br decode_word_loop
		dont_print:

		srli r19, r19, 1 # shift word bit mask
		subi r17, r17, 1 # decr count of total bits left
		br decode_word_loop
	end_decode_word_loop:

	addi r16, r16, 4 # incr ptr to nxt wrd

	br decode_loop # go back and load it

end_decode:
	ldw ra,   0(sp)
	ldw r16,  4(sp)
	ldw r17,  8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	ldw r20, 20(sp)
	addi sp, sp, 24

	ret

