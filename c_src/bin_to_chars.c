#include "common.c"
#include <stdio.h>

int main() {
	unsigned char in_stream[2048];
	unsigned char* ptr_in_in_stream = in_stream;
	int num_inchars;
	num_inchars = fgetall(in_stream, sizeof(in_stream));

	for(; num_inchars > 0; --num_inchars) {
		for(size_t i = 0; i < 8; ++i) {
			if (((*ptr_in_in_stream) & 0x80) == 0) {
				putchar('0');
			} else {
				putchar('1');
			}
			*ptr_in_in_stream <<= 1;
		}
		ptr_in_in_stream++;
	}
}
