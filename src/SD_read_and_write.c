#include "io.h"

#define READ_BLOCK_CMD 0x11
int read_file(int block, int *sd_addr) {

	int *command_argument_register = sd_addr + 556/4;
	short int *command_register = (short int *)(sd_addr + 560/4);
	short int *aux_status_register = (short int *)(sd_addr + 564/4);
	short int status;

	/* Wait for the SD Card to be connected to the SD Card Port. */
	do {
		status = (short int) IORD_16DIRECT(aux_status_register, 0);
	} while ((status & 0x02) == 0);

	/* Read from block */
	IOWR_32DIRECT(command_argument_register, 0, (block) * 512);
	IOWR_16DIRECT(command_register, 0, READ_BLOCK_CMD);

	/* Wait until the operation completes. */
	do {
		status = (short int) IORD_16DIRECT(aux_status_register, 0);
	} while ((status & 0x04)!=0);
}

#define WRITE_BLOCK_CMD 0x18
int write_file(int block, int *sd_addr) {

	int *command_argument_register = sd_addr + 556/4;
	short int *command_register = (short int *)(sd_addr + 560/4);
	short int *aux_status_register = (short int *)(sd_addr + 564/4);
	short int status;

	/* Wait for the SD Card to be connected to the SD Card Port. */
	do {
		status = (short int) IORD_16DIRECT(aux_status_register, 0);
	} while ((status & 0x02) == 0);

	/* write to block */
	IOWR_32DIRECT(command_argument_register, 0, (block) * 512);
	IOWR_16DIRECT(command_register, 0, WRITE_BLOCK_CMD);

	/* Wait until the operation completes. */
	do {
		status = (short int) IORD_16DIRECT(aux_status_register, 0);
	} while ((status & 0x04)!=0);
}
