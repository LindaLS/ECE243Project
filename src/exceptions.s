.section .exceptions, "ax"
ISR:
	rdctlr et, ipending
	andi et, et, 0x100

	bne et, end
	


end:
	addi ea, ea, -4
	eret
