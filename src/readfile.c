#define READ_BLOCK 0x11
int read_file(int block, int *sd_addr) {

	int *command_argument_register = sd_addr + 556;
	short int *command_register = sd_addr + 560;
	short int *aux_status_register = sd_addr + 564;
	short int status;

	/* Wait for the SD Card to be connected to the SD Card Port. */
	do {
		status = (short int) IORD_16DIRECT(aux_status_register, 0);
	} while ((status & 0x02) == 0);
	
	/* Read 11th sector on the card */
	IOWR_32DIRECT(command_argument_register, 0, (block) * 512);
	IOWR_16DIRECT(command_register, 0, READ_BLOCK);
	
	/* Wait until the operation completes. */
	do {
		status = (short int) IORD_16DIRECT(aux_status_register, 0);
	} while ((status & 0x04)!=0);
}