#include "altera_up_avalon_usb.h"
#include "altera_up_avalon_usb_low_level_driver.h"
#include "altera_up_avalon_usb_high_level_driver.h"
#include "altera_up_avalon_usb_regs.h"
#include "altera_up_avalon_usb_mouse_driver.h"
#include "sys/alt_stdio.h"

/* globals */
//#define BUF_SIZE 500000			// about 10 seconds of buffer (@ 48K samples/sec)
//#define BUF_THRESHOLD 96		// 75% of 128 word buffer

/* function prototypes */
//void HEX_PS2(unsigned char, unsigned char, unsigned char);
//void check_KEYs( int *, int *, int *, alt_up_parallel_port_dev *, alt_up_audio_dev * );

/********************************************************************************
 * This program demonstrates use of the media ports in the DE2 Media Computer
 *
 * It performs the following: 
 *  	1. records audio for about 10 seconds when KEY[1] is pressed. LEDG[0] is
 *  	   lit while recording
 * 	2. plays the recorded audio when KEY[2] is pressed. LEDG[1] is lit while 
 * 	   playing
 * 	3. Draws a blue box on the VGA display, and places a text string inside
 * 	   the box
 * 	4. Shows a text message on the LCD display
 * 	5. Displays the last three bytes of data received from the PS/2 port 
 * 	   on the HEX displays on the DE2 board
********************************************************************************/
int main(void)
{
	alt_up_usb_dev *usb_dev;

	int errors = 0, count = 0;
	unsigned long rhp1, rhp2;
	unsigned int status;
	unsigned int ccode=0;
	unsigned int rbuf[128];
	unsigned int iManufacturer,iProduct;
	unsigned int mouse01=0,mouse02=0;
	unsigned int mycode;
//	alt_up_parallel_port_dev *KEY_dev;
//	alt_up_ps2_dev *PS2_dev;
//	alt_up_audio_dev *audio_dev;
//	alt_up_character_lcd_dev *lcd_dev;
//	alt_up_char_buffer_dev *char_buffer_dev;
//	alt_up_pixel_buffer_dma_dev *pixel_buffer_dev;

//	/* used for audio record/playback */
//	int record = 0, play = 0, buffer_index = 0;
//	unsigned int l_buf[BUF_SIZE];
//	unsigned int r_buf[BUF_SIZE];
//	int num_read; int num_written;

//	/* used for PS/2 port data */
//	unsigned char PS2_data;
//	unsigned char byte1 = 0, byte2 = 0, byte3 = 0;

	/* create a message to be displayed on the VGA and LCD displays */
//	char text_top_row[40] = "Altera DE2\0";
//	char text_bottom_row[40] = "Media Computer\0";

	/* open the usb controller */
	usb_dev = alt_up_usb_open_dev ("/dev/USB_avalon_usb_slave");
	if (usb_dev == NULL)
	{
		alt_printf ("Error: could not open USB controller device\n");
		return -1;
	}
	else
		alt_printf ("Opened USB controller device\n");

    printf ("USB Base Address: %4X\n", usb_dev->base);
    printf ("Read Chip ID: %4X\n", alt_up_usb_hc_reg_read_16(usb_dev, 0x27));

	// Test HC scratch reg
	do {
        alt_up_usb_hc_reg_write_16(usb_dev, 0x28, count);
         if (count != alt_up_usb_hc_reg_read_16(usb_dev, 0x28)) {
            printf("Error Encountered at %d\n", count);
            errors++;
         }
    } while (++count <= 0xFFFF);
    
    if (errors == 0) {
        printf("No errors writing and reading from HC scratch reg.\n");
    } else {
        printf("There were %d errors writing and reading from HC scratch reg.\n", errors);
    }
	// End test HC scratch reg

    printf("Initialize defaults for HC controller\n");
    alt_up_usb_hc_initialize_defaults(usb_dev);
    printf("Setup USB Operational mode\n");
    alt_up_usb_hc_set_operational(usb_dev);
//    printf("Disable all USB interrupts\n");
//    alt_up_usb_hc_disable_all_interrupts(usb_dev);
    printf("Enable Ports\n");
    alt_up_usb_enable_ports(usb_dev);

    printf("Length of ATL: %4d\n", alt_up_usb_hc_reg_read_16(usb_dev, ALT_UP_USB_HcATLBufferSize));
    printf("Length of PTL: %4d\n", alt_up_usb_hc_reg_read_16(usb_dev, ALT_UP_USB_HcISTLBufferSize));
    printf("Length of INT: %4d\n", alt_up_usb_hc_reg_read_16(usb_dev, ALT_UP_USB_HcINTLBufferSize));
	
    // Start checking if something is connected
    rhp1 = alt_up_usb_hc_reg_read_32( usb_dev, ALT_UP_USB_HcRhPortStatus1 );
    rhp2 = alt_up_usb_hc_reg_read_32( usb_dev, ALT_UP_USB_HcRhPortStatus2 );    
    printf("RhP1 = %8lX  RhP2 = %8lX\n", rhp1, rhp2);
    printf("Port1Speed = %2d\n", alt_up_usb_get_port_speed(ALT_UP_USB_PORT_1));
    printf("Port2Speed = %2d\n", alt_up_usb_get_port_speed(ALT_UP_USB_PORT_2));
    
    if ((rhp2 & 0x01) == 1) {
        printf("Port 2 has USB device connected, assigning address 2...\n");
        ccode = alt_up_usb_set_address( usb_dev, ALT_UP_USB_PORT_2, 0, 2);
        status=0x0001|(ccode<<4);
        printf ("MyStatus = %X\n", status);
    }

//    alt_up_usb_hc_reg_write_16(usb_dev, ALT_UP_USB_HcuPInterruptEnable, 0x120);

 if( (status&0x0001)!=0) //port 2 active
 {
//  Check port 2 for mouse
  mycode=alt_up_usb_get_control(usb_dev, rbuf,2,'D',0,2);
  printf("MyCode = %X\n", mycode);
  if(mycode==0x0300)
  {
   iManufacturer = rbuf[7]&0xFF;
   iProduct = (rbuf[7]&0xFF00)>>8;
   alt_up_usb_addr_info(2,'W','O',iManufacturer);
   alt_up_usb_addr_info(2,'W','P',iProduct);
   mycode=alt_up_usb_get_control(usb_dev,rbuf,2,'H',alt_up_usb_addr_info(2,'R','P',0),2);
   printf("Device found? %4X\n", *(rbuf + 1));
   if( *(rbuf+1)==0x0209  )
   {
       printf("Mouse Detected\n");
       mouse02=1;
       
       mycode = alt_up_usb_set_config( usb_dev, 2, 2, 1 );

       printf("Set Config MyCode = %X\n", mycode);
       if(mycode==0) alt_up_usb_play_mouse( usb_dev, 2, 2 );
       
   } else if( *(rbuf+1)==0x0609  ){
       printf("Keyboard Detected\n");
       mouse02=1;
       
       mycode = alt_up_usb_set_config( usb_dev, 2, 2, 1 );

       printf("Set Config MyCode = %X\n", mycode);
       if(mycode==0) alt_up_usb_play_keyboard( usb_dev, 2, 2 );
       
   }
   
  }
 }
    
    printf("End My Test\n");
//	alt_up_character_lcd_set_cursor_pos (lcd_dev, 0, 0);	// set LCD cursor location to top row
//	alt_up_character_lcd_string (lcd_dev, text_top_row);
//	alt_up_character_lcd_set_cursor_pos (lcd_dev, 0, 1);	// set LCD cursor location to bottom row
//	alt_up_character_lcd_string (lcd_dev, text_bottom_row);
//	alt_up_character_lcd_cursor_off (lcd_dev);				// turn off the LCD cursor 

//	/* output text message in the middle of the VGA monitor */
//	char_buffer_dev = alt_up_char_buffer_open_dev ("/dev/VGA_Char_Buffer");
//	if (char_buffer_dev == NULL)
//	{
//		alt_printf ("Error: could not open character buffer device\n");
//		return -1;
//	}
//	else
//		alt_printf ("Opened character buffer device\n");
//	alt_up_char_buffer_string (char_buffer_dev, text_top_row, 35, 29);
//	alt_up_char_buffer_string (char_buffer_dev, text_bottom_row, 35, 30);

//	/* open the pixel buffer */
//	pixel_buffer_dev = alt_up_pixel_buffer_dma_open_dev ("/dev/VGA_Pixel_Buffer");
//	if (pixel_buffer_dev == NULL)
//	{
//		alt_printf ("Error: could not open pixel buffer device\n");
//		return -1;
//	}
//	else
//		alt_printf ("Opened pixel buffer device\n");

//	alt_up_pixel_buffer_dma_clear_screen (pixel_buffer_dev, 0);
	/* draw a medium-blue box in the middle of the screen, using character buffer coordinates.
	 * Use character coord * 4 since characters are 4 x 4 pixel buffer coords (8 x 8 VGA coords) */
//	alt_up_pixel_buffer_dma_draw_box (pixel_buffer_dev, 34 * 4, 28 * 4, 50 * 4, 32 * 4, 0x187F, 0);
	
	// open the PS2 port
//	PS2_dev = alt_up_ps2_open_dev ("/dev/PS2_Port");
//	if (PS2_dev == NULL)
//	{
//		alt_printf ("Error: could not open PS2 device\n");
//		return -1;
//	}
//	else
//		alt_printf ("Opened PS2 device\n");
//
//	audio_dev = alt_up_audio_open_dev ("/dev/Audio");
//	if (audio_dev == NULL)
//	{
//		alt_printf ("Error: could not open audio device\n");
//		return -1;
//	}
//	else
//		alt_printf ("Opened audio device\n");
//
//	/* read and echo audio data */
//	record = 0;
//	play = 0;
//	// open the pushbuttom KEY parallel port
//	KEY_dev = alt_up_parallel_port_open_dev ("/dev/Pushbuttons");
//	if ( KEY_dev == NULL)
//	{
//		alt_printf ("Error: could not open pushbutton KEY device\n");
//		return -1;
//	}
//	else
//		alt_printf ("Opened pushbutton KEY device\n");

//	// open the green LEDs parallel port
//	green_LEDs_dev = alt_up_parallel_port_open_dev ("/dev/Green_LEDs");
//	if (green_LEDs_dev == NULL)
//	{
//		alt_printf ("Error: could not open green LEDs device\n");
//		return -1;
//	}
//	else
//		alt_printf ("Opened green LEDs device\n");

//	(void) alt_up_ps2_write_data_byte (PS2_dev, 0xFF);		// reset
//	while(1)
//	{
//		check_KEYs ( &record, &play, &buffer_index, KEY_dev, audio_dev );
//		if (record)
//		{
//			alt_up_parallel_port_write_data(green_LEDs_dev, 0x1); // set LEDG[0] on

//			// record data until the buffer is full
//			if (buffer_index < BUF_SIZE)
//			{
//				num_read = alt_up_audio_record_r (audio_dev, &(r_buf[buffer_index]), 
//					BUF_SIZE - buffer_index);
//				/* assume we can read same # words from the left and right */
//				(void) alt_up_audio_record_l (audio_dev, &(l_buf[buffer_index]), 
//					num_read);
//				buffer_index += num_read;
//
//				if (buffer_index == BUF_SIZE)
//				{
//					// done recording
//					record = 0;
//					alt_up_parallel_port_write_data(green_LEDs_dev, 0x0); // set LEDG off
//				}
//			}
//		}
//		else if (play)
//		{
//			alt_up_parallel_port_write_data(green_LEDs_dev, 0x2); // set LEDG[1] on
//
//			// output data until the buffer is empty 
//			if (buffer_index < BUF_SIZE)
//			{
//				num_written = alt_up_audio_play_r (audio_dev, &(r_buf[buffer_index]), 
//				 	BUF_SIZE - buffer_index);
//				/* assume that we can write the same # words to the left and right */
//				(void) alt_up_audio_play_l (audio_dev, &(l_buf[buffer_index]), 
//					num_written);
//				buffer_index += num_written;

//				if (buffer_index == BUF_SIZE)
//				{
//					// done playback
//					play = 0;
//					alt_up_parallel_port_write_data(green_LEDs_dev, 0x0); // set LEDG off
//				}
//			}
//		}
//		/* check for PS/2 data--display on HEX displays */
//		if (alt_up_ps2_read_data_byte (PS2_dev, &PS2_data) == 0)
//		{
//			/* shift the next data byte into the display */
//			byte1 = byte2;
//			byte2 = byte3;
//			byte3 = PS2_data;
//			HEX_PS2 (byte1, byte2, byte3);

//			if ( (byte2 == (unsigned char) 0xAA) && (byte3 == (unsigned char) 0x00) )
//				// mouse inserted; initialize sending of data
//				(void) alt_up_ps2_write_data_byte (PS2_dev, 0xF4);
//		}
//	}
}

/****************************************************************************************
 * Subroutine to show a string of HEX data on the HEX displays
 * Note that we are using pointer accesses for the HEX displays parallel port. We could
 * also use the HAL functions for these ports instead.
****************************************************************************************/
//void HEX_PS2(unsigned char b1, unsigned char b2, unsigned char b3)
//{
//	volatile int *HEX3_HEX0_ptr = (int *) 0x10000020;
//	volatile int *HEX7_HEX4_ptr = (int *) 0x10000030;

	/* SEVEN_SEGMENT_DECODE_TABLE gives the on/off settings for all segments in 
	 * a single 7-seg display in the DE2 Media Computer, for the hex digits 0 - F */
//	unsigned char	seven_seg_decode_table[] = {	0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7C, 0x07, 
//		  										0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71 };
//	unsigned char	hex_segs[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
//	unsigned int shift_buffer, nibble;
//	unsigned char code;
//	int i;

//	shift_buffer = (b1 << 16) | (b2 << 8) | b3;
//	for ( i = 0; i < 6; ++i )
//	{
//		nibble = shift_buffer & 0x0000000F;		// character is in rightmost nibble
//		code = seven_seg_decode_table[nibble];
//		hex_segs[i] = code;
//		shift_buffer = shift_buffer >> 4;
//	}
//	/* drive the hex displays */
//	*(HEX3_HEX0_ptr) = *(int *) (hex_segs);
//	*(HEX7_HEX4_ptr) = *(int *) (hex_segs+4);
//}

/****************************************************************************************
 * Subroutine to read KEYs
****************************************************************************************/
//void check_KEYs(int *KEY1, int *KEY2, int *counter, alt_up_parallel_port_dev *KEY_dev,
//	alt_up_audio_dev *audio_dev)
//{
//	int KEY_value;

//	KEY_value = alt_up_parallel_port_read_data (KEY_dev);
	
//	while ( alt_up_parallel_port_read_data (KEY_dev) );	// wait for pushbutton KEY release

//	if (KEY_value == 0x2)					// check KEY1
//	{
		// reset counter to start recording
//		*counter = 0;
		// reset audio port
//		alt_up_audio_reset_audio_core (audio_dev);

//		*KEY1 = 1;
//	}
//	else if (KEY_value == 0x4)				// check KEY2
//	{
		// reset counter to start playback
//		*counter = 0;
		// reset audio port
//		alt_up_audio_reset_audio_core (audio_dev);

//		*KEY2 = 1;
//	}
//}
