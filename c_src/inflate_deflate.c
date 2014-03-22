#define NUM_NODES 27
#define NUM_CHAR 27
#define MAX_DEPTH 11


Node node[NUM_NODES];
char convert_table { "00000", //a
					 "0001100", //b
					 "011111", //c
					 "000011", //d
					 "0010", //e
					 "010111", //f
					 "0001111", //g
					 "00110", //h
					 "00111", //i
					 "0101100011", //j
					 "01011001", //k
					 "000010", //l
					 "010101", //m
					 "01101", //n
					 "00010", //o
					 "0001101", //p
					 "0101100001", //q
					 "01110", //r
					 "01100", //s
					 "0100", //t
					 "011110", //u
					 "0101101", //v
					 "010100", //w
					 "0101100010", //x
					 "0001110", //y
					 "0101100000", //z
					 "1", //' '
 };

typedef struct Node
{
	int value;
	struct Node *left;
	struct Node *right;
} Node;

void inflate(char *in_stream){

	return;
}

void print_out_tree(Node* treeptr, char* in_stream) {
	if (treeptr->value > 0) {

	}
}

void deflate(char *in_stream, char *out_stream){

	return;
}

void build_tree(){
	
	return;
}

int main(){

	return 0;	
}
