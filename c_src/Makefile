
CFLAGS += -std=c99 -ggdb

TARGETS = encode decode chars_to_bin bin_to_chars

all: $(TARGETS)

encode: inflate_deflate.c ../src/data.c common.c
	gcc $(CFLAGS) inflate_deflate.c -o encode -DENCODE

decode: inflate_deflate.c ../src/data.c common.c
	gcc $(CFLAGS) inflate_deflate.c -o decode -DDECODE

chars_to_bin: chars_to_bin.c common.c
	gcc $(CFLAGS) chars_to_bin.c -o chars_to_bin

bin_to_chars: bin_to_chars.c common.c
	gcc $(CFLAGS) bin_to_chars.c -o bin_to_chars

clean:
	rm $(TARGETS)