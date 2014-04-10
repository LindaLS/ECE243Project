
CFLAGS += -std=c99 -ggdb

TARGETS = encode decode chars_to_bin

all: $(TARGETS)

encode: inflate_deflate.c ../src/data.c common.c
	gcc $(CFLAGS) inflate_deflate.c -o encode -DENCODE

decode: inflate_deflate.c ../src/data.c common.c
	gcc $(CFLAGS) inflate_deflate.c -o decode -DDECODE

chars_to_bin: chars_to_bin.c common.c
	gcc $(CFLAGS) chars_to_bin.c -o chars_to_bin

clean:
	rm $(TARGETS)