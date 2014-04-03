.section .data
.align 2

HUFF_TREE:
.word 0,   HUFF_TREE + 3*1,  HUFF_TREE + 3*52 #node 0
.word 0,   HUFF_TREE + 3*2,  HUFF_TREE + 3*23 #node 1 
.word 0,   HUFF_TREE + 3*3,  HUFF_TREE + 3*18 #node 2
.word 0,   HUFF_TREE + 3*4,  HUFF_TREE + 3*9 #node 3
.word 0,   HUFF_TREE + 3*5,  HUFF_TREE + 3*6 #node 4
.word 'a', NULL,           NULL #node 5
.word 0,   HUFF_TREE + 3*7,   HUFF_TREE + 3*8 #node 6
.word 'l', NULL,           NULL #node 7
.word 'd', NULL,           NULL #node 8
.word 0,   HUFF_TREE + 3*10, HUFF_TREE + 3*11 #node 9
.word 'o', NULL,           NULL #node 10
.word 0,   HUFF_TREE + 3*12, HUFF_TREE + 3*15 #node 11
.word 0,   HUFF_TREE + 3*13, HUFF_TREE + 3*14 #node 12
.word 'b', NULL,           NULL #node 13
.word 'p', NULL,           NULL #node 14
.word 0,   HUFF_TREE + 3*16, HUFF_TREE + 3*17 #node 15
.word 'y', NULL,           NULL #node 16
.word 'g', NULL,           NULL #node 17
.word 0,   HUFF_TREE + 3*19, HUFF_TREE + 3*20 #node 18
.word 'e', NULL,           NULL #node 19
.word 0,   HUFF_TREE + 3*21, HUFF_TREE + 3*22 #node 20
.word 'h', NULL,           NULL #node 21
.word 'i', NULL,           NULL #node 22
.word 0,   HUFF_TREE + 3*24, HUFF_TREE + 3*43 #node 23
.word 0,   HUFF_TREE + 3*25, HUFF_TREE + 3*26 #node 24
.word 't', NULL,           NULL #node 25
.word 0,   HUFF_TREE + 3*27, HUFF_TREE + 3*30 #node 26
.word 0,   HUFF_TREE + 3*28, HUFF_TREE + 3*29 #node 27
.word 'w', NULL,           NULL #node 28
.word 'm', NULL,           NULL #node 29
.word 0,   HUFF_TREE + 3*31, HUFF_TREE + 3*42 #node 30
.word 0,   HUFF_TREE + 3*32, HUFF_TREE + 3*41 #node 31
.word 0,   HUFF_TREE + 3*33, HUFF_TREE + 3*40 #node 32
.word 0,   HUFF_TREE + 3*34, HUFF_TREE + 3*37 #node 33
.word 0,   HUFF_TREE + 3*35, HUFF_TREE + 3*36 #node 34
.word 'z', NULL,           NULL #node 35
.word 'q', NULL,           NULL #node 36
.word 0,   HUFF_TREE + 3*38, HUFF_TREE + 3*39 #node 37
.word 'x', NULL,           NULL #node 38
.word 'j', NULL,           NULL #node 39
.word 'k', NULL,           NULL #node 40
.word 'v', NULL,           NULL #node 41
.word 'f', NULL,           NULL #node 42
.word 0,   HUFF_TREE + 3*44, HUFF_TREE + 3*47 #node 43
.word 0,   HUFF_TREE + 3*45, HUFF_TREE + 3*46 #node 44
.word 's', NULL,           NULL #node 45
.word 'n', NULL,           NULL #node 46
.word 0,   HUFF_TREE + 3*48, HUFF_TREE + 3*49 #node 47
.word 'r', NULL,           NULL #node 48
.word 0,   HUFF_TREE + 3*50, HUFF_TREE + 3*51 #node 49
.word 'u', NULL,           NULL #node 50
.word 'c', NULL,           NULL #node 51
.word ' ', NULL,           NULL  #node 52

.equ SPACE_INDEX, 26

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
.word 10, 0b0101100011 #j
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
.word 5,  0b011110     #u
.word 7,  0b0101101    #v
.word 6,  0b010100     #w
.word 10, 0b0101100010 #x
.word 7,  0b0001110    #y
.word 10, 0b0101100000 #z
.word 1,  0b1          #' '

#a to z plus space encoded
#000000001100011111000011001001011100011110011000111010110001101011001000010010101011010001000011010101100001011100110001001111001011010101000101100010000111001011000001