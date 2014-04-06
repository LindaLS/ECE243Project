.include "nios_macros.s"

.global _start
_start:
	movia r8, 0x00800000
	ldh r9, 564(r8)
end: br end
