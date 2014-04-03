.section .exceptions, "ax"
ISR:
	rdctlr et, ipending
	andi et, et, 0x100

	bne et, end_isr


	subi sp, sp, 36
	stw ra,   0(sp)
	stw r16,  4(sp)
	stw r17,  8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)
	stw r21, 24(sp)
	stw r22, 28(sp)
	stw r23, 32(sp)

	andi r22, et, 0b10
	beq r22, r0, end_isr

	
	


end_isr:
	stw ra,   0(sp)
	stw r16,  4(sp)
	stw r17,  8(sp)
	stw r18, 12(sp)
	stw r19, 16(sp)
	stw r20, 20(sp)
	stw r21, 24(sp)
	stw r22, 28(sp)
	stw r23, 32(sp)
	addi sp, sp, 36

	addi ea, ea, -4
	eret
