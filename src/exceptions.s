.section .exceptions, "ax"
ISR:

	rdctl et, ipending
	andi et, et, 0b010

	beq et, r0, end_isr


	subi sp, sp, 36
	stw ra,   0(sp)
	# stw r16,  4(sp)
	stw r17,  8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)
	stw r21, 24(sp)
	stw r22, 28(sp)
	stw r23, 32(sp)
	stw et, 4(sp)
	
	andi r22, et, 0b10
	beq r22, r0, check_timer

	movia r22,PUSH_BUTTON_ADDR
	#ldwio r21, 0(r22)   #Read in buttons - active low
	stwio r0, 0xc(r22)

	#xori r21, r21, 0xf

	movi r21, 1

	movia r22, BUTTONS_PUSHED
	stw r21, 0(r22)
	br end_isr

check_timer:
	andi r22, et, 0b10
	beq r22, r0, end_isr
	movia r21, ADDR_GREENLEDS
	movia r20, 0
	stwio r20, (r21)

	movia et, TIMER_ADDRESS
	stwio r0, (et)
	movui r20, %lo(ONE_SEC)
	stwio r20, 8(et)
	movui r20, %hi(ONE_SEC)
	stwio r20, 12(et)
	movui r20, 0b101
	stwio r20, 4(et)
	ldw et, 4(sp)
	wrctl estatus, et



end_isr:
	ldw ra,   0(sp)
	# ldw r16,  4(sp)
	ldw r17,  8(sp)
	ldw r18, 12(sp)
	ldw r19, 16(sp)
	ldw r20, 20(sp)
	ldw r21, 24(sp)
	ldw r22, 28(sp)
	ldw r23, 32(sp)
	ldw et, 4(sp)

	addi sp, sp, 36

	addi ea, ea, -4
	eret
