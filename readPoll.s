.global poll_read
.global poll_write

# movia r4, 0x10001020  #r7 now contains the base address
poll_read:
  ldwio r2, 0(r4) #Load from the JTAG
  andi  r3, r2, 0x8000 # Mask other bits
  beq   r3, r0, poll_read # If this is 0 (branch true), data is not valid
  andi  r3, r2, 0x00FF # Data read is now in r3

  ret



poll_write:
  ldwio r3, 4(r4) # Load from the JTAG
  srli  r3, r3, 16 # Check only the write available bits
  beq   r3, r0, poll_write # If this is 0 (branch true), data cannot be sent
  stwio r5, 0(r4) # Write the byte to the JTAG

  ret