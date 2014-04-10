#include "../src/data.c"
#include <stdio.h>

void inflate(char *in_stream){
	printf("\"");
	while (*in_stream) {
		in_stream += print_out_tree(node, in_stream);
	}
	printf("\"\n");
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

void deflate(char *in_stream){
	while(*in_stream){
		switch (*in_stream) {
			case ' ':
  				printf("%s", convert_table[26]);
  				break;
			case '\n':
				printf("%s", convert_table[27]);
				break;
			default:
				printf("%s", convert_table[ (*in_stream)- 'a']);
				break;
		}
		in_stream++;
	}
	printf("\n");

	return;
}

int main(){
	char in_stream[] = 
	"000000001011111000000000110001111100001100100101110001111001100011101011000110010110001110101100100001001010101101000100001101010110000101110011000100011110010110101010001011000100001110010110000011"
	;

	inflate(in_stream);
	deflate(
		"hello world my name is linda with a capital l"
	);
	return 0;	
}
