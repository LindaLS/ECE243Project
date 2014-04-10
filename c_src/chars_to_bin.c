#include "common.c"
#include <stdio.h>

int main() {
	char in_stream[512*10];
	fgetall(in_stream, sizeof(in_stream));
	output_as_bits(in_stream);
	output_as_bits("00000000"); // flush the buffer
}
