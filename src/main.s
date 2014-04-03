.include "nios_macros.s"
.include "defs.s"
.include "data.s"
.include "readPoll.s"
.include "print_encoding.s"
.include "get_encoding.s"
.include "deflate.s"
.include "inflate.s"

.section .data

.align 2
buttons_pushed:
.word 0

.section .text
.global main
main:


movia r2, PUSH_BUTTON_ADDR
movia r3,0xe
stwio r3,8(r2)  /* Enable interrupts on push buttons 1,2, and 3 */

movia r2,IRQ_PUSHBUTTONS
wrctl ctl3,r2   /* Enable bit 5 - button interrupt on Processor */

movia r2,1
wrctl ctl0,r2   /* Enable global Interrupts on Processor */

BUTTON_WAIT_LOOP:
movia r8 buttons_pushed
ldw r8, 0(r8)
bne r8, r0, BUTTON_WAIT_LOOP
movia r9, buttons_pushed
stw r0, buttons_pushed

andi r9, r8, 0b10
bne r9, r0, ENCODE_DATA
andi r9, r8, 0b100
bne r9, r0, DECODE
br BUTTON_WAIT_LOOP

ENCODE_DATA:
	call encode_data
	br BUTTON_WAIT_LOOP

DECODE:	
	subi sp, sp, 4
	stw ra, 0(sp)

	movia r4, COMPRESSED_DATA
	movia r5, COMPRESSED_DATA_LENGTH
	ldw r5, 0(r5)

	call decode_and_print
	br BUTTON_WAIT_LOOP

STOP:
	br STOP;

.end