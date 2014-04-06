#define NUM_NODES 52
#define NUM_CHAR 27
#define MAX_DEPTH 11
#include <stdlib.h>

#define JTAG_ADDRESS 0x10001000
#define PUSH_BUTTON_ADDR 0x10000050
#define IRQ_PUSHBUTTONS 0x02
#define SLIDER_SWITCHES 0x10000040

int BUTTONS_PUSHED = 0;

typedef struct Node
{
	char value;
	struct Node *left;
	struct Node *right;
} Node;

Node node[] = {
			  { 0,   &node[1],  &node[52]}, //node 0
			  { 0,   &node[2],  &node[23]}, //node 1 
			  { 0,   &node[3],  &node[18]}, //node 2
			  { 0,   &node[4],   &node[9]}, //node 3
			  { 0,   &node[5],   &node[6]}, //node 4
			  { 'a', NULL,           NULL}, //node 5
			  { 0,   &node[7],   &node[8]}, //node 6
			  { 'l', NULL,           NULL}, //node 7
			  { 'd', NULL,           NULL}, //node 8
			  { 0,   &node[10], &node[11]}, //node 9
			  { 'o', NULL,           NULL}, //node 10
			  { 0,   &node[12], &node[15]}, //node 11
			  { 0,   &node[13], &node[14]}, //node 12
			  { 'b', NULL,           NULL}, //node 13
			  { 'p', NULL,           NULL}, //node 14
			  { 0,   &node[16], &node[17]}, //node 15
			  { 'y', NULL,           NULL}, //node 16
			  { 'g', NULL,           NULL}, //node 17
			  { 0,   &node[19], &node[20]}, //node 18
			  { 'e', NULL,           NULL}, //node 19
			  { 0,   &node[21], &node[22]}, //node 20
			  { 'h', NULL,           NULL}, //node 21
			  { 'i', NULL,           NULL}, //node 22
			  { 0,   &node[24], &node[43]}, //node 23
			  { 0,   &node[25], &node[26]}, //node 24
			  { 't', NULL,           NULL}, //node 25
			  { 0,   &node[27], &node[30]}, //node 26
			  { 0,   &node[28], &node[29]}, //node 27
			  { 'w', NULL,           NULL}, //node 28
			  { 'm', NULL,           NULL}, //node 29
			  { 0,   &node[31], &node[42]}, //node 30
			  { 0,   &node[32], &node[41]}, //node 31
			  { 0,   &node[33], &node[40]}, //node 32
			  { 0,   &node[34], &node[37]}, //node 33
			  { 0,   &node[35], &node[36]}, //node 34
			  { 'z', NULL,           NULL}, //node 35
			  { 'q', NULL,           NULL}, //node 36
			  { 0,   &node[38], &node[39]}, //node 37
			  { 'x', NULL,           NULL}, //node 38
			  { 'j', NULL,           NULL}, //node 39
			  { 'k', NULL,           NULL}, //node 40
			  { 'v', NULL,           NULL}, //node 41
			  { 'f', NULL,           NULL}, //node 42
			  { 0,   &node[44], &node[47]}, //node 43
			  { 0,   &node[45], &node[46]}, //node 44
			  { 's', NULL,           NULL}, //node 45
			  { 'n', NULL,           NULL}, //node 46
			  { 0,   &node[48], &node[49]}, //node 47
			  { 'r', NULL,           NULL}, //node 48
			  { 0,   &node[50], &node[51]}, //node 49
			  { 'u', NULL,           NULL}, //node 50
			  { 'c', NULL,           NULL}, //node 51
			  { ' ', NULL,           NULL}, //node 52
};
char *convert_table[] = { "00000",     //a
					      "0001100",   //b
					      "011111",    //c
					      "000011",    //d
					      "0010",      //e
					      "010111",    //f
					      "0001111",   //g
					      "00110",     //h
					      "00111",     //i
					      "0101100011",//j
					      "01011001",  //k
					      "000010",    //l
					      "010101",    //m
					      "01101",     //n
					      "00010",     //o
					      "0001101",   //p
					      "0101100001",//q
					      "01110",     //r
					      "01100",     //s
					      "0100",      //t
					      "011110",    //u
					      "0101101",   //v
					      "010100",    //w
					      "0101100010",//x
					      "0001110",   //y
					      "0101100000",//z
					      "1",         //' '
 };

