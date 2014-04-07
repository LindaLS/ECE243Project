#include <altera_up_sd_card_avalon_interface.h>

int read(char* filename, char* write_to,int length) {
	alt_up_sd_card_dev *device_reference = NULL;
	int connected = 0;
	device_reference = alt_up_sd_card_open_dev("/dev/the_Altera_UP_SD_Card_Avalon_Interface_0");
	
	if (device_reference != NULL) return 0x000;
	if (!alt_up_sd_card_is_Present()) return 0x000;
	if (!alt_up_sd_card_is_FAT16()) return 0x000;

	short int file_handle;
	file_handle = alt_up_sd_card_fopen(filename, 0);
	if (file_handle < 0) return 0x000;


	while (length) {
		alt_up_sd_card_write(ﬁle_handle, write_to);
		write_to++;
		length--;
	}

	alt_up_sd_card_fclose(ﬁle_handle);

	return 0x111;
}