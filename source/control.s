.section .text



/* Initializes the SNES controller GPIO
 * args: none
 * pre: none
 * post: clk to output, ltch to output, data to input
 * return: none
 */

.globl InitCont
InitCont:

	gpfsel1	.req	r4					// holds address for function sel. reg 1
	gpfsel0	.req	r5					// holds address for function sel. reg 0
	
	
	push	{r4-r5, lr}
	
	/*
	* set GPIO pin 11 to output (CLK)
	*/
	
	ldr		gpfsel1, =0x20200004		// set func sel 1 address
	ldr		r0, [gpfsel1]				// get value of func sel 1
	mov		r1, #7						// b0111
	lsl		r1, #3						// prepare to clear bits 3-5
	bic		r0, r1						// clear bits
	mov		r2, #1						// output code (001)
	lsl		r2, #3						// shift r2 to line 1 (GPIO 11)
	orr		r0, r2						// set line 1 to output
	str		r0, [gpfsel1]				// write back to func sel 1


	/*
	* set GPIO pin 9 to output (LATCH)
	*/
	
	ldr		gpfsel0, =0x20200000		// set func sel 0 address
	ldr		r0, [gpfsel0]				// get value of func sel 0
	mov		r1, #7						// b0111
	lsl		r1, #27						// prepare to clear bits 27-29
	bic		r0, r1						// clear bits
	mov		r2, #1						// output code (001)
	lsl		r2, #27						// shift r2 to line 9 (GPIO 9)
	orr		r0, r2						// set line 9 to output
	str		r0, [gpfsel0]				// write back to func sel 0
	
	
	/*
	* set GPIO pin 10 to input (DATA)
	*/
	
	ldr		r0, [gpfsel1]				// get value of func sel 0
	mov		r1, #7						// b0111
	bic		r0, r1						// clear bits for line 1, output (000)
	str		r0, [gpfsel1]				// write back to func sel 1

	.unreq	gpfsel0
	.unreq	gpfsel1
	
	pop		{r4-r5, pc}



/* Reads the data line to see if the pin is high or low
 * args: none
 * pre: the controller should be initialized
 * post: none
 * return: r0 contains {0,1} depending whether pin was high or low
 */
	
.globl ReadData
ReadData:

	gpfsel0 .req	r4					// holds address for function sel. reg 0

	
	push	{r4-r5, lr}
	
	ldr		gpfsel0, =0x20200000		// set address for func sel 0
	
	mov		r1, 	#10					// data is pin #10
	ldr		r3,	[gpfsel0, #52]			// GPLEV0

	mov		r2, #1						// making a mask
	lsl		r2,	r1						// align to pin 10
	
	and		r3,	r2						// mask GPLEV0
	teq		r3,	#0						// test if the pin is low
	
	moveq	r0, #0						// return 0 in r0
	movne	r0, #1						// return 1 in r0
	
	.unreq	gpfsel0
	
	pop		{r4-r5, pc}	
	
	
	


/* Writes a bit to the clock line 
 * args: r0 passes a 1 or 0 to write
 * pre:	controller should be initialized 
 * post: a bit is written to the clock line (GPSCLR0 or GPSET0)
 * return: none
 */

.globl WriteClock
WriteClock:

	gpfsel0	.req	r4					// holds address for function sel. reg 1
	
	push	{r4, lr}
	
	ldr		gpfsel0, =0x20200000		// set address for func sel 0
	
	mov		r1,	#1						// set up a mask
	mov		r2, #11						// clock is pin #11
	lsl		r1, r2						// align to pin #11
	teq		r0, #0						// check if the arg passed is 0
	streq	r1,	[gpfsel0, #40]			// GPSCLR0 if r0 is 0
	strne 	r1,	[gpfsel0, #28]			// GPSET0 if r0 is 1
	
	.unreq	gpfsel0
	
	pop		{r4, pc}
	
	
	
	
	
	
	
	
/* Writes a bit to the latch line
 * args: r0 passes a 1 or 0 to write
 * pre: controller should be initialized
 * post: a bit is written to the latch line (GPSCLR0 or GPSET0)
 * return: none
 */

.globl	WriteLatch
WriteLatch:

	gpfsel0	.req	r4					// holds address for function sel. reg 1
	
	push	{r4, lr}

	ldr		gpfsel0, =0x20200000		// set address for func sel 1
	
	mov		r1,	#1						// set up a mask
	mov		r2,	#9						// latch is pin #9 
	lsl		r1, r2						// align to pin #9
	teq		r0, #0						// check if the arg passed is 0
	streq	r1,	[gpfsel0, #40]			// GPSCLR0if r0 is 0
	strne 	r1,	[gpfsel0, #28]			// GPSET0 if r0 is 1
	
	.unreq	gpfsel0
	
	pop		{r4, pc}




/* 
 * args: none
 * pre:	controller must be initialized
 * post: the controller has been cycled
 * return: r0, which contains the mask of which buttons were pressed
 */
 
.globl ReadFromCont
ReadFromCont:


	push	{r4-r5, lr}
	

	count	.req	r4					// a counter
	butns	.req	r5					// address for buttons

	mov		butns, #0					// reseting the register

	mov		r0, #1						// passed arg = 1
	bl		WriteClock					// write 1 to GPIO clock line
	mov		r0,	#1						// passed arg = 1
	bl		WriteLatch					// write 1 to GPIO latch line
	
	mov		r0, #12						// passed arg = 12
	bl		Wait						// wait 12 micros
	
										// passed arg = 0
	bl		WriteLatch					// write 0
	
	
	mov		count,	#0					// reset the count


	/*
	*	The loop which pulses cycles to read from the SNES
	*/
	
	pulseloop:

	mov		r0, #6						// passed arg = 6
	bl		Wait						// wait 6 micros
	
										// passed arg = 0
	bl		WriteClock					// write 0
	
	mov		r0, #6						// passed arg = 6
	bl		Wait						// wait 6 micros
	
	bl		ReadData					// read the GPIO data line
										// returned arg = r0 (0 or 1)
	
	cmp		r0, #1						// check if the data line was high
	
	bne		continue					// branch when data line is not high (r0 = 0)

	/*
	*	Fall to here if data line is high, ie: button pressed
	*/
	
	mov		r2, #1						// make a mask
	lsl		r2, count					// align mask to current button
	orr		butns, r2					// write the current button press


	continue:							// branched here when r0 == 0

	mov		r0, #1						// passed arg = 1
	bl		WriteClock					// write 1

	add		count, #1					// count++
	
	cmp		count, #16					// test to see if count == 16 yet
	bne		pulseloop					// branch to read next button cycle

	mov		r0, butns					// buttons pressed returned

	.unreq	count
	.unreq	butns
	
	pop		{r4-r5, pc}







/* Performs a delay of micro seconds, used when pulsing controller
 * args: r0 passes a time to wait in micro seconds
 * pre: none
 * post: the system has waited r0 micro seconds
 * return: none
 */
 
.globl	Wait
Wait:

	timer	.req	r4					// holds address for CLO register

	push	{r4, lr}

	ldr		timer,	=0x20003004			// CLO register address

	ldr		r1, [timer]					// load value of CLO
	add		r1, r0						// add r0 micro seconds
	
	waitloop:
		ldr		r2,	[timer]				// load value of CLO
		cmp		r1,	r2					// stop when CLO = r1
		bhi		waitloop				// loop

	mov		r0, #0						// reset r0
	.unreq	timer
	
	pop		{r4, pc}
	

.section .data





