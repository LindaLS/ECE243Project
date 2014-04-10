#include <stdio.h>

void output_as_bits(char* binary_string) {
	static char buffer = 0;
	static size_t bits_in_char = 0;
	while (*binary_string) {
		buffer <<= 1;
		switch (*binary_string) {
			case '1':
				buffer++; // set bit 0 to 1
				// fall through
			case '0':
				bits_in_char++;
				break;
			default:
				printf("found something that's not a 0 or 1\n");
			break;
		}
		if (bits_in_char >= 8) {
			putchar(buffer);
			buffer = 0;
			bits_in_char = 0;
		}
		binary_string++;
	}
}

size_t fgetall(char* in_stream, size_t max_inchars) {
	size_t num_inchars = 0;
	
	while (1) {
		char in = getchar();
		if (in == EOF || num_inchars >= max_inchars) {
			in_stream[num_inchars] = 0;
			break;
		}
		in_stream[num_inchars] = in;
		num_inchars++;
	}

	return num_inchars;
}