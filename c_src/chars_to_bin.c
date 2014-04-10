#include "common.c"
#include <stdio.h>

int main() {
	char in_stream[2048];
	fgetall(in_stream, sizeof(in_stream));
	output_as_bits(in_stream);
}
