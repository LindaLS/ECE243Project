
.section .text
.global decode_and_print
.global decode_and_print_getlengthfirst

# params
# r4 - ptr to data to read
# r6 - ptr to buffer to write to
decode_and_print_getlengthfirst:
	ldbu r5, 0(r4)
	slli r5, r5, 8
	ldbu r8, 1(r4) 
	add r5, r5, r8
	addi r4, r4, 2

# params
# r4 - ptr to data to read
# r5 - max number of bytes to read here
# r6 - ptr to buffer to write to

decode_and_print:
	subi sp, sp, 28
	stw ra,   0(sp)
	stw r16,  4(sp)
	stw r17,  8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)
	stw r21, 24(sp)

	mov r16, r4
	mov r17, r5
	movia r20, HUFF_TREE
	mov r21, r6

decode_loop:
	# andi r8, r16, 0b11 # get offset from word boundary
	# andi r16, r16, 0xFFFC # round down to word boundary
	ldbu r18, 0(r16) # load word at ptr
	# now init the bit mask propery
	movia r19, 0x80
# shift_loop:
# 	beq r8, r0, decode_word_loop
# 	srli r19, r19, 8
# 	subi r8, r8, 1
# 	br shift_loop

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
		bne r5, r0, interpret_node # if not 0, figure out what it means
		
		and r5, r18, r19 # mask out bit
		bne r5, r0, go_right # if not 0 go right

		go_left:
			ldw r20, 4(r20) # treeptr = *(treeptr + 4)
			br keep_going
		go_right:
			ldw r20, 8(r20) # treeptr = *(treeptr + 8)
			br keep_going

		interpret_node:
			andhi r6, r5, 0xFFFF # mask out distance
			andi r7, r5, 0xFFFF # mask out length
			beq r6, r0, copy_char_to_buffer # if upper bytes 0, is character
			srli r6, r6, 16 # shift distance data into lower bytes
			sub r6, r21, r6 # calculate new readpos
			copy_bytes:
				ble r7, r0, done_copying_bytes # loop until no bytes left
				ldbu r5, 0(r6) # read
				stb r5, 0(r21) # write
				movia r4, JTAG_ADDRESS
				call poll_write
				addi r6, r6, 1 # ++readpos
				addi r21, r21, 1 # ++writebufferptr
				subi r7, r7, 1 # --bytesleft
				br copy_bytes
			done_copying_bytes:
				movia r20, HUFF_TREE # reset treeptr
				br decode_word_loop

		copy_char_to_buffer:
			movia r4, JTAG_ADDRESS
			call poll_write # print the char
			stb r5, 0(r21) # write to buffer
			addi r21, r21, 1 # ++writebufferptr 
			movia r20, HUFF_TREE # reset treeptr
			br decode_word_loop

		keep_going:

		srli r19, r19, 1 # shift word bit mask
		subi r17, r17, 1 # decr count of total bits left
		br decode_word_loop
	end_decode_word_loop:

	addi r16, r16, 1 # incr ptr to nxt byt

	br decode_loop # go back and load it

end_decode:
	stb r0, 0(r21) # write null terminator
	ldw ra,   0(sp)
	ldw r16,  4(sp)
	ldw r17,  8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	ldw r20, 20(sp)
	ldw r21, 24(sp)
	addi sp, sp, 28

	ret








