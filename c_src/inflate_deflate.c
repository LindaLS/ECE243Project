#include "../src/data.c"
#include <stdio.h>
#include "common.c"

int print_out_tree(Node* treeptr, char* in_stream);
void encode(char *in_stream);

void decode(char *in_stream){
	int num_bits;
	for (size_t i = 0; i < 16; ++i) {
		num_bits <<= 1;
		switch (*in_stream) {
			case '1':
				num_bits++; // set bit 0 to 1
				// fall through
			case '0':
				in_stream++;
				break;
			default:
				printf("found something that's not a 0 or 1\n");
			break;
		}
	}
	while (num_bits > 0) {
		size_t bits_read = print_out_tree(node, in_stream);
		in_stream += bits_read;
		num_bits -= bits_read;
	}
	return;
}

int print_out_tree(Node* treeptr, char* in_stream) {
	if (treeptr->value > 0) {
		printf("%c", treeptr->value);
		return 0;
	}
	if (*in_stream == '0') {
		return 1 + print_out_tree(treeptr->left, in_stream+1);
	}
	if (*in_stream == '1') {
		return 1 + print_out_tree(treeptr->right, in_stream+1);
	}
	return 0;
}

void encode(char *in_stream) {
	while(*in_stream){
		switch (*in_stream) {
			case ' ':
  				printf("%s", convert_table[26]);
  				break;
			case '\n':
				printf("%s", convert_table[27]);
				break;
			default:
				if (*in_stream < 'a' || *in_stream > 'z') {
					printf("unencodable char in input: '%c'\n", *in_stream);
				} else {
					printf("%s", convert_table[ (*in_stream)- 'a']);
				}
				break;
		}
		in_stream++;
	}
	return;
}

#if !(defined DECODE || defined ENCODE)
	#error please define either ENCODE or DECODE
#endif

int main(){
	char test_in_stream[] = 
	"000000001011111000000000110001111100001100100101110001111001100011101011000110010110001110101100100001001010101101000100001101010110000101110011000100011110010110101010001011000100001110010110000011"
	;

	char in_stream[2048];

	fgetall(in_stream, sizeof(in_stream));

	#ifdef DECODE
	decode(in_stream);
	#endif

	#ifdef ENCODE
	encode(
		in_stream
		// "baa baa black sheep\n"
		// "have you any wool\n"
		// "yes sir yes sir\n"
		// "three bags full\n"
		// "one for the master\n"
		// "one for the dame\n"
		// "one for the little boy\n"
		// "who lives down the lane\n"
	);
	#endif

	return 0;	
}
