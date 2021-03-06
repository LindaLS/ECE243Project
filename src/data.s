.section .data
.align 2

BUTTONS_PUSHED:
.word 0

HUFF_TREE:
.word 0,   HUFF_TREE + 12*1,  HUFF_TREE + 12*52 #node 0
.word 0,   HUFF_TREE + 12*2,  HUFF_TREE + 12*23 #node 1 
.word 0,   HUFF_TREE + 12*3,  HUFF_TREE + 12*18 #node 2
.word 0,   HUFF_TREE + 12*4,  HUFF_TREE + 12*9 #node 3
.word 0,   HUFF_TREE + 12*5,  HUFF_TREE + 12*6 #node 4
.word 'a', NULL,           NULL #node 5
.word 0,   HUFF_TREE + 12*7,  HUFF_TREE + 12*8 #node 6
.word 'l', NULL,           NULL #node 7
.word 'd', NULL,           NULL #node 8
.word 0,   HUFF_TREE + 12*10, HUFF_TREE + 12*11 #node 9
.word 'o', NULL,           NULL #node 10
.word 0,   HUFF_TREE + 12*12, HUFF_TREE + 12*15 #node 11
.word 0,   HUFF_TREE + 12*13, HUFF_TREE + 12*14 #node 12
.word 'b', NULL,           NULL #node 13
.word 'p', NULL,           NULL #node 14
.word 0,   HUFF_TREE + 12*16, HUFF_TREE + 12*17 #node 15
.word 'y', NULL,           NULL #node 16
.word 'g', NULL,           NULL #node 17
.word 0,   HUFF_TREE + 12*19, HUFF_TREE + 12*20 #node 18
.word 'e', NULL,           NULL #node 19
.word 0,   HUFF_TREE + 12*21, HUFF_TREE + 12*22 #node 20
.word 'h', NULL,           NULL #node 21
.word 'i', NULL,           NULL #node 22
.word 0,   HUFF_TREE + 12*24, HUFF_TREE + 12*43 #node 23
.word 0,   HUFF_TREE + 12*25, HUFF_TREE + 12*26 #node 24
.word 't', NULL,           NULL #node 25
.word 0,   HUFF_TREE + 12*27, HUFF_TREE + 12*30 #node 26
.word 0,   HUFF_TREE + 12*28, HUFF_TREE + 12*29 #node 27
.word 'w', NULL,           NULL #node 28
.word 'm', NULL,           NULL #node 29
.word 0,   HUFF_TREE + 12*31, HUFF_TREE + 12*42 #node 30
.word 0,   HUFF_TREE + 12*32, HUFF_TREE + 12*41 #node 31
.word 0,   HUFF_TREE + 12*33, HUFF_TREE + 12*40 #node 32
.word 0,   HUFF_TREE + 12*34, HUFF_TREE + 12*37 #node 33
.word 0,   HUFF_TREE + 12*35, HUFF_TREE + 12*36 #node 34
.word 'z', NULL,           NULL #node 35
.word 'q', NULL,           NULL #node 36
.word 0,   HUFF_TREE + 12*38, HUFF_TREE + 12*39 #node 37
.word 'x', NULL,           NULL #node 38
.word 0,   HUFF_TREE + 12*54, HUFF_TREE + 12*55 #node 39
.word 'k', NULL,           NULL #node 40
.word 'v', NULL,           NULL #node 41
.word 'f', NULL,           NULL #node 42
.word 0,   HUFF_TREE + 12*44, HUFF_TREE + 12*47 #node 43
.word 0,   HUFF_TREE + 12*45, HUFF_TREE + 12*46 #node 44
.word 's', NULL,           NULL #node 45
.word 'n', NULL,           NULL #node 46
.word 0,   HUFF_TREE + 12*48, HUFF_TREE + 12*49 #node 47
.word 'r', NULL,           NULL #node 48
.word 0,   HUFF_TREE + 12*50, HUFF_TREE + 12*51 #node 49
.word 'u', NULL,           NULL #node 50
.word 'c', NULL,           NULL #node 51
.word 0,   HUFF_TREE + 12*56, HUFF_TREE + 12*53 #node 52
.word ' ', NULL,           NULL #node 53
.word 'j', NULL,           NULL #node 54
.word '\n', NULL,           NULL #node 55
.word 0,   HUFF_TREE + 12*57, HUFF_TREE + 12*58 #node 56 (10)
.word 0,   HUFF_TREE + 12*59, HUFF_TREE + 12*60 #node 57 (100)
.word 0,   HUFF_TREE + 12*61, HUFF_TREE + 12*62 #node 58 (101)
.word 0x00040004, NULL,    NULL #node 59 -- go back 4, copy 4 (1000)
.word 0x00080007, NULL,    NULL #node 60 -- go back 8, copy 7 (1001)
.word 0x0013000D, NULL,    NULL #node 61 -- go back 19, copy 13 (1010)
.word 0x0011000D, NULL,    NULL #node 62 -- go back 17, copy 13 (1011)

.equ SPACE_INDEX, 26
.equ NEWLINE_INDEX, 27

.align 2
ENCODE_TABLE:
.word 5,  0b00000      #a
.word 7,  0b0001100    #b
.word 6,  0b011111     #c
.word 6,  0b000011     #d
.word 4,  0b0010       #e
.word 6,  0b010111     #f
.word 7,  0b0001111    #g
.word 5,  0b00110      #h
.word 5,  0b00111      #i
.word 11, 0b01011000110 #j
.word 8,  0b01011001   #k
.word 6,  0b000010     #l
.word 6,  0b010101     #m
.word 5,  0b01101      #n
.word 5,  0b00010      #o
.word 7,  0b0001101    #p
.word 10, 0b0101100001 #q
.word 5,  0b01110      #r
.word 5,  0b01100      #s
.word 4,  0b0100       #t
.word 6,  0b011110     #u
.word 7,  0b0101101    #v
.word 6,  0b010100     #w
.word 10, 0b0101100010 #x
.word 7,  0b0001110    #y
.word 10, 0b0101100000 #z
.word 2,  0b11         #' '
.word 11, 0b01011000111 #\n


.align 2
BLOCK_BUFFER:
.skip 512

.align 2
.word 0 # a fallback null, for printing the buffer

.align 2
BLOCK_BUFFER_LENGTH:
# less than or equal to 512 please
.word 512


.align 2
TEST_UNCOMPRESSED_DATA:
	.string "abcdefghij\nklmnopqrstuvwxy Az"

.align 2
.byte 1,2,3,4,5,6,7,8,9

.align 2
TEST_COMPRESSED_DATA:
	.byte 0b00000010, 0b01100000
	.byte 0b00011000, 0b00000000, 0b01110000, 0b00110000
	.byte 0b00100000, 0b00111110, 0b10110011, 0b10110000
	.byte 0b11000100, 0b01000011, 0b01010110, 0b00111001
	.byte 0b10000000, 0b10110100, 0b10110001, 0b11000010
	.byte 0b01111011, 0b00000011, 0b01000111, 0b01101010
	.byte 0b00001000, 0b01000001, 0b00101100, 0b01110001
	.byte 0b11000100, 0b11001101, 0b10000111, 0b01110111
	.byte 0b00101011, 0b00011101, 0b00001100, 0b11100010
	.byte 0b00101100, 0b01100000, 0b00000111, 0b10110011
	.byte 0b01011101, 0b11100000, 0b10000010, 0b01011000
	.byte 0b11100010, 0b01101001, 0b01101011, 0b10001001
	.byte 0b11011010, 0b00011000, 0b10110101, 0b01000000
	.byte 0b11000100, 0b00100111, 0b01010000, 0b01100000
	.byte 0b01010100, 0b10101100, 0b00100011, 0b10100010
	.byte 0b00000100, 0b01011000, 0b11000001, 0b00001110
	.byte 0b01011000, 0b11101010, 0b00011000, 0b01011000
	.byte 0b01000111, 0b01011010, 0b01001100, 0b11000011
	.byte 0b00010010, 0b10001101, 0b11010000, 0b11000101
	.byte 0b10000100, 0b00000110, 0b10010010, 0b11000111

	# .byte 0b00000000, 0b10111110, 0b00000000, 0b11000111
	# .byte 0b11000011, 0b00100101, 0b11000111, 0b10011000
	# .byte 0b11101011, 0b00011001, 0b01100011, 0b10101100
	# .byte 0b10000100, 0b10101011, 0b01000100, 0b00110101
	# .byte 0b01100001, 0b01110011, 0b00010001, 0b11100101
	# .byte 0b10101010, 0b00101100, 0b01000011, 0b10010110
	# .byte 0b00001110, 0b01101111, 0b11111111, 0b11111111
	               #last one ^

.align 2
TEST_COMPRESSED_DATA_LENGTH:
	.word 608

