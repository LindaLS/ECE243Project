.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/nios_macros.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/defs.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/data.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/readPoll.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/print_encoding.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/get_encoding.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/deflate.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/inflate.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/exceptions.s"
.include "/home/matt/Documents/school/University/year_2 (2013)/semester_2/ECE243-Comp.Org./project/ECE243Project/src/buffer.s"


.global main
.section .text
main:

movia r2, PUSH_BUTTON_ADDR
movia r3,0xe
stwio r3,8(r2)  #Enable interrupts on push buttons 1,2, and 3

movia r2, IRQ_DEVICES
wrctl ctl3,r2   #Enable bit 5 - button interrupt on Processor

movia r2,1
wrctl ctl0,r2   #Enable global Interrupts on Processor



#start timer
movia r4, TIMER_ADDRESS
movui r5, %lo(ONE_SEC)
stwio r5, 8(r4)
movui r5, %hi(ONE_SEC)
stwio r5, 12(r4)

stwio r0, 0(r4) #reset timer
movui r5,  0b101 #enable start, cont, interups

stwio r5, 4(r8)
#done setting timer


BUTTON_WAIT_LOOP:
	movia r8, BUTTONS_PUSHED
	ldw r8, 0(r8)
	beq r8, r0, BUTTON_WAIT_LOOP
	
	movia r9, BUTTONS_PUSHED
	stw r0, 0(r9)

	movia r8, SLIDER_SWITCHES
	ldw r8, 0(r8)


	andi r9, r8, 0b111 # r9 holds opcode
	beq r9, r0, LED_OFF

	andi r10, r8, 0xFFF8
	srli r10, r10, 3 # 10 holds arguements
	
	movia r11, 0b010
	beq r9, r11, DECODE_DATA
	movia r11, 0b011
	beq r9, r11, ENCODE_DATA
	movia r11, 0b101
	beq r9, r11, READ_SD
	movia r11, 0b100
	beq r9, r11, WRITE_SD

br BUTTON_WAIT_LOOP


ENCODE_DATA:
	andi r10, r10, 0b1
	movia r4, TEST_UNCOMPRESSED_DATA
	bne r10, r0, actually_encode # if not 0, keep r4 as TEST_UNCOMPRESSED_DATA
	movia r4, SD_ADDR # if 0 set it to the SD card core's buffer

actually_encode:
	movia r5, BLOCK_BUFFER
	call encode_data
	br LED_ON

DECODE_DATA:
	andi r10, r10, 0b1
	movia r4, TEST_COMPRESSED_DATA
	bne r10, r0, actually_decode # if 0 keep them at TEST_COMPRESSED_DATA
	movia r4, SD_ADDR
	
actually_decode:
	movia r6, BLOCK_BUFFER
	call decode_and_print_getlengthfirst
	br LED_ON

READ_SD:
	andi r4, r10, 0b11
	movia r5, SD_ADDR
	call read_file

	movia r4, BLOCK_BUFFER
	movia r5, SD_ADDR
	movia r6, BLOCK_BUFFER_LENGTH
	ldw r6, 0(r6)
	call copy_buffer
	br LED_ON

WRITE_SD:
	movia r4, SD_ADDR
	movia r5, BLOCK_BUFFER
	movia r6, BLOCK_BUFFER_LENGTH
	call copy_buffer

	andi r4, r10, 0b11
	movia r5, SD_ADDR
	call write_file

	br LED_ON
	

LED_OFF:
	movia r8, ADDR_GREENLEDS
	movia r9, 0
	stwio r9, 0(r8)

	br BUTTON_WAIT_LOOP

LED_ON:
	movia r8, ADDR_GREENLEDS
	movia r9, 0x1
	stwio r9, 0(r8)

	br BUTTON_WAIT_LOOP


STOP:
	br STOP;

.end
