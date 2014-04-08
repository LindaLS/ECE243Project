.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/nios_macros.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/defs.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/data.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/readPoll.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/print_encoding.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/get_encoding.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/deflate.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/inflate.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/exceptions.s"

.global main
main:

movia r2, PUSH_BUTTON_ADDR
movia r3,0xe
stwio r3,8(r2)  #Enable interrupts on push buttons 1,2, and 3

movia r2, IRQ_PUSHBUTTONS
wrctl ctl3,r2   #Enable bit 5 - button interrupt on Processor

movia r2,1
wrctl ctl0,r2   #Enable global Interrupts on Processor

BUTTON_WAIT_LOOP:
	movia r8, BUTTONS_PUSHED
	ldw r8, 0(r8)
	beq r8, r0, BUTTON_WAIT_LOOP
	
	movia r9, BUTTONS_PUSHED
	stw r0, 0(r9)

	movia r8, SLIDER_SWITCHES
	ldw r8, 0(r8)

	andi r9, r8, 0b00
	beq r9, r0, LED_OFF
	andi r9, r8, 0b10
	beq r9, r0, ENCODE_DATA
	andi r9, r8, 0b11
	beq r9, r0, DECODE
	andi r9, r8, 0b100
	beq r9, r0, READ_SD
	# br DECODE

br BUTTON_WAIT_LOOP


ENCODE_DATA:
	call encode_data
	br LED_ON

DECODE:	
	subi sp, sp, 4
	stw ra, 0(sp)

	movia r4, TEST_COMPRESSED_DATA
	movia r5, TEST_COMPRESSED_DATA_LENGTH
	ldw r5, 0(r5)

	call decode_and_print
	br LED_ON

READ_SD:

	movia r4, 0
	movia r5, SD_ADDR
	call read_file
	br LED_ON

LED_OFF:
	movia r8, ADDR_GREENLEDS
	movia r9, 0
	stwio r9, 0(r8)

	br BUTTON_WAIT_LOOP

LED_ON:
	movia r8, ADDR_GREENLEDS
	movia r9, 0xffffffff
	stwio r9, 0(r8)

	br BUTTON_WAIT_LOOP


STOP:
	br STOP;

.end
